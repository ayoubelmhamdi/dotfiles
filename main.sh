#!/bin/sh
# main.sh — symlink dotfiles from this repo into place. Idempotent: just re-run.
# Takes no arguments and no flags. Reads ./manifest.txt sitting next to it.
#
# manifest line:  SOURCE|TARGET|PERMS[|PLATFORM][|sudo]
#   SOURCE    path inside this repo; a trailing "/" marks a directory
#   TARGET    where the symlink goes; a leading "~" becomes $HOME
#   PERMS     octal mode for the real file, e.g. 644 or 755
#   PLATFORM  empty or "universe" = every machine; else an /etc/os-release
#             ID or ID_LIKE token (void, debian, ubuntu, ...), or wsl / termux
#   sudo      literal word "sudo" => run this line's mkdir/ln/chmod via sudo
# Blank lines and lines beginning with "#" are ignored.

set -e

script_dir="$( cd "$( dirname "$0" )" && pwd -P )"
manifest="$script_dir/configs-files/manifest.txt"

# a literal carriage return, used to tolerate CRLF (Windows/WSL) line endings in the manifest
cr="$( printf '\r' )"

if [ ! -r "$manifest" ]; then
    echo "main.sh: cannot read manifest: $manifest" >&2
    exit 1
fi

# Build the set of platform tokens that are active on THIS machine.
# "universe" always matches. We add os-release ID + ID_LIKE, then wsl / termux
# when detected, then an explicit PLATFORM=... override. If nothing concrete is
# found we refuse to guess and tell the user how to force it.
detected_platforms="universe"
found_real_platform="no"

if [ -r /etc/os-release ]; then
    detected_platforms="$detected_platforms $( . /etc/os-release; echo "$ID $ID_LIKE" )"
    found_real_platform="yes"
fi
if [ -n "${WSL_DISTRO_NAME:-}" ] || grep -qi microsoft /proc/version 2>/dev/null; then
    detected_platforms="$detected_platforms wsl"
    found_real_platform="yes"
fi
if [ -n "${TERMUX_VERSION:-}" ] || [ -d /data/data/com.termux/files/usr ]; then
    detected_platforms="$detected_platforms termux"
    found_real_platform="yes"
fi
if [ -n "${PLATFORM:-}" ]; then
    detected_platforms="$detected_platforms $PLATFORM"
    found_real_platform="yes"
fi
if [ "$found_real_platform" = "no" ]; then
    echo "main.sh: could not detect this platform (no /etc/os-release, not wsl/termux)" >&2
    echo "main.sh: re-run with an explicit platform, e.g. PLATFORM=termux ./main.sh" >&2
    exit 1
fi

while IFS='|' read -r source target perms platform sudoflag || [ -n "$source" ]; do

    # tolerate CRLF line endings: a trailing carriage return lands on the line's last field
    source="${source%"$cr"}"
    target="${target%"$cr"}"
    perms="${perms%"$cr"}"
    platform="${platform%"$cr"}"
    sudoflag="${sudoflag%"$cr"}"

    # strip any leading whitespace so indented comments and blank lines are still recognised
    while : ; do
        case "$source" in
            [[:blank:]]*) source="${source#?}" ;;
            *) break ;;
        esac
    done

    # skip blank lines and comments
    case "$source" in
        ""|"#"*) continue ;;
    esac

    # "SRC|TGT|PERMS|sudo" is shorthand for "SRC|TGT|PERMS||sudo" (sudo is never a platform name)
    if [ "$platform" = "sudo" ] && [ -z "$sudoflag" ]; then
        platform=""
        sudoflag="sudo"
    fi

    # does this line apply to the current machine?
    line_applies="no"
    if [ -z "$platform" ] || [ "$platform" = "universe" ]; then
        line_applies="yes"
    else
        case " $detected_platforms " in
            *" $platform "*) line_applies="yes" ;;
        esac
    fi
    [ "$line_applies" = "yes" ] || continue

    # basic sanity on the line
    if [ -z "$target" ]; then
        echo "main.sh: missing target for source '$source'" >&2
        exit 1
    fi
    if [ -z "$perms" ]; then
        echo "main.sh: missing perms for source '$source'" >&2
        exit 1
    fi

    # sudo wrapper for this line, if it was asked for
    sudo_prefix=""
    if [ "$sudoflag" = "sudo" ]; then
        if ! command -v sudo >/dev/null 2>&1; then
            echo "main.sh: '$target' needs sudo but sudo is not installed" >&2
            exit 1
        fi
        sudo_prefix="sudo"
    fi

    # real source inside the repo (drop any trailing slash for the fs path)
    source_abs="$script_dir/configs-files/${source%/}"


    # a trailing slash in the manifest means "this is a directory"
    case "$source" in
        */) if [ ! -d "$source_abs" ]; then
                echo "main.sh: source directory missing: $source_abs" >&2
                exit 1
            fi ;;
        *)  if [ ! -f "$source_abs" ]; then
                echo "main.sh: source file missing: $source_abs" >&2
                exit 1
            fi ;;
    esac

    # expand a leading ~ in the target, then drop any trailing slash
    case "$target" in
        "~")   target_abs="$HOME" ;;
        "~/"*) target_abs="$HOME/${target#"~/"}" ;;
        *)     target_abs="$target" ;;
    esac
    target_abs="${target_abs%/}"

    if [ -L "$target_abs" ]; then
        # already a symlink: it must point exactly at our source ...
        current_link="$( readlink "$target_abs" )"
        if [ "$current_link" != "$source_abs" ]; then
            echo "main.sh: $target_abs points to '$current_link', expected '$source_abs'" >&2
            exit 1
        fi
        # ... and the real file's mode must match the manifest
        current_mode="$( stat -c '%a' "$source_abs" )"
        # normalise both sides before comparing: drop a leading zero in the manifest mode
        # (0644 == 644), and ignore stat's leading setuid/setgid/sticky digit (e.g. 2755 -> 755)
        compare_current="$current_mode"
        compare_wanted="$perms"
        case "$compare_wanted" in 0*) compare_wanted="${compare_wanted#0}" ;; esac
        case "$compare_current" in ????) compare_current="${compare_current#?}" ;; esac
        case "$compare_wanted" in ????) compare_wanted="${compare_wanted#?}" ;; esac
        if [ "$compare_current" != "$compare_wanted" ]; then
            echo "main.sh: $source_abs has mode $current_mode, manifest says $perms" >&2
            exit 1
        fi
        echo "ok    $target_abs -> $source_abs ($perms)"
    elif [ -e "$target_abs" ]; then
        # a real file/dir is in the way: never clobber it
        echo "main.sh: $target_abs already exists and is not a symlink, refusing to touch it" >&2
        exit 1
    else
        # nothing there yet. Make the parent dir, stamp the mode, THEN create the link.
        # chmod before ln so a failed chmod can't leave a half-made link that panics on every re-run.
        $sudo_prefix mkdir -p "$( dirname "$target_abs" )"
        $sudo_prefix chmod "$perms" "$source_abs"
        $sudo_prefix ln -s "$source_abs" "$target_abs"
        echo "link  $target_abs -> $source_abs ($perms)"
    fi

done < "$manifest"
