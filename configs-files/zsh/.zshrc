#!/bin/zsh



# if touch "/data" ; then
#   builtin cd /data
# elif touch "$HOME/data" ; then
#   builtin cd $HOME/data
# fi
#
# can we moved them into ~/.xinitrc
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh &)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh &)"
fi

if command -v doas >/dev/null 2>&1; then
    alias sudo='command doas'
fi


fpath=(~/.config/fpath $fpath)

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


##############################################
setopt INTERACTIVECOMMENTS

set      bell-style none # prevend readline emit a bell
unsetopt BEEP            # turn off bell in Terminal when an invalid action occurs.
unsetopt LIST_BEEP       # completion list should not scary me.
setopt   NO_NOMATCH      # disables throw error if a glob like *.txt unmatched. i want the same behaviour like bash.

setopt INC_APPEND_HISTORY # add commands to HISTFILE in order of execution
# setopt EXTENDED_HISTORY   # uncomment it's not help add time to zshhistory like `:1659681839:0;cat hist`
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicated commands history list

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export LISTMAX=6             # Number of completions shown w/o asking

# export TIMEFMT=$TIMEFMT       # Format for reporting usage with time
# export WATCHFMT=$WATCHFMT     # Format of reports for $watch

# ENV VARIABLE
export DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster
export EDITOR=nvim
export PAGER=bat
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1



# GO SETTINGS
export CGO_ENABLED=1
export CGO_CFLAGS="-g -O2 -Wno-return-local-addr"
export GOPATH="$HOME/go/"
export PATH="$GOPATH/bin:$PATH"

# alias ls="command ls"
# unalias ls 2>/dev/null
##############################################



### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Force emacs line-editing keymap (Alt+d, Alt+b/f, Ctrl+a/e, word motions...).
# zsh auto-selects vi-mode (viins) at startup whenever $EDITOR or $VISUAL
# contains the substring "vi" -- and "nvim" does. A plain terminal doesn't have
# EDITOR exported before zsh starts, so it gets emacs; but the tmux server
# inherits EDITOR=nvim and hands it to every pane, so panes start in vi-mode.
# That is why vi-mode appeared ONLY inside tmux. `bindkey -e` pins emacs
# regardless of $EDITOR/tmux, and MUST run before the bindkey calls below so
# they bind into the emacs keymap (not viins).
bindkey -e

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

function copy-buffer-to-clipboard() {
  echo -n "$BUFFER" | pbcopy
  zle -M "Copied to clipboard"
}
zle -N copy-buffer-to-clipboard
bindkey '^X^C' copy-buffer-to-clipboard


##########################
# OMZ Libs and Plugins   #
##########################


# PLUGIN CONFIG
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1      # UP/dwon without fuzzy finder
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1 # do no duplicate search
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1          # make prompt faster
export ABBR_EXPAND_AND_ACCEPT_PUSH_ABBREVIATED_LINE_TO_HISTORY=0
export ABBR_EXPAND_PUSH_ABBREVIATED_LINE_TO_HISTORY=0


# # put abbr after zsh-completion to make sure the completion work at least fine and not make abbr fuck up my complition.
# zinit wait:1 lucid atload for olets/zsh-abbr


zinit wait lucid for \
    OMZL::completion.zsh \
    # OMZL::compfix.zsh \
    # OMZL::correction.zsh \
    # OMZL::clipboard.zsh \
    # OMZL::history.zsh \
    # OMZL::key-bindings.zsh \
    # OMZL::spectrum.zsh \


# Plugin
# <condition>..then..<plugin>
zinit wait lucid light-mode depth=1 for \
    atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting    \
    atinit"zicompinit; zicdreplay"          \
    atload"                                 \
        bindkey '^[[A' history-substring-search-up;   \
        bindkey '^[[B' history-substring-search-down; \
        bindkey '^P'   history-substring-search-up;   \
        bindkey '^N'   history-substring-search-down" \
        zsh-users/zsh-history-substring-search  \
    atload"zicompinit; zicdreplay" blockf   \
        zsh-users/zsh-completions           \
    wait'0'          \
        olets/zsh-abbr                      \
    wait'0' atload"_zsh_autosuggest_start"          \
        zsh-users/zsh-autosuggestions       \

# complete
bindkey '^@'        forward-word   # key <C-Space>
bindkey '^[[1;5C'   forward-word   # key <C-right>
bindkey '^[[1;5D'   backward-word  # key <C-Left>
bindkey '^B'        backward-char


bindkey '\e[13;5u'  accept-line # ctrl + Enter

# assert default
bindkey '^A'        beginning-of-line
bindkey "^E"        end-of-line
bindkey "^M"        accept-line
bindkey "^[[P"      delete-char
bindkey "^[[3~"     delete-char




if [[ -s $HOME/.config/zsh  ]];then
    for file in $HOME/.config/zsh/* $HOME/.config/zsh-post/*;do
        zi ice lucid wait'0'
        zi snippet "$file"
    done
fi

export SPACESHIP_EXIT_CODE_SHOW=true

alias vn='NVIM_APPNAME=nvim-nvchad     nvim' # NvChad
alias vk='NVIM_APPNAME=nvim-kickstart  nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astrovim   nvim' # AstroVim

xcp-cookies(){
    /data/projects/py/netscape-cookies-2-json/main.py "$1" | xclip -selection clipboard
}


bashx() (
    set -o pipefail
    PS4='+ ' bash -x "$@" 2>&1 | grcat conf.bashtrace
)

mv_(){ 
    echo 'ici1'
    file="$1"

    cwd=`pwd`
    if [ -h "$file" ];then
        sleep 0.1; clear
        full_path="$(realpath --relative-to=../new-bin/ "$file")"

        cd "/home/mhamdi/scripts/new-bin"
        base_name="$(basename $file)"
        git_name="$(git ls-files | grep "$base_name")"
        echo "git_name: $git_name"
        if [ -n "$git_name" ];then
            echo git rm "../bin/$base_name" && echo git mv "$full_path" . 
        else
            echo rm "../bin/$base_name" && mv "$full_path" .
        fi

    elif [ -f "$file" ];then
        cd "/home/mhamdi/scripts/new-bin"
        echo cd `pwd`
        if [ -n "$(git ls-files "../bin/$base_name")" ]; then
            echo git mv "../bin/$base_name" .

            echo git rm "../bin/$base_name" && echo git mv "$full_path" . 
        else
            echo rm "../bin/$base_name" && mv "$full_path" .
        fi

    elif [ -f "$file" ];then
        cd "/home/mhamdi/scripts/new-bin"
        echo cd `pwd`
        if [ -n "$(git ls-files "../bin/$base_name")" ]; then
            echo git mv "../bin/$base_name" .
            echo git add "../bin/$base_name"
            echo git commit -m "'moved into new-bin'" "../bin/$base_name"
        else
            echo mv "../bin/$base_name" .
        fi

    else
        echo "ERROR: symlink $file file not exist"
        cd "$cwd"
        return 1
    fi

    echo v "$file"
    cd "$cwd"
}


_fsz2() {
    [ "$#" -eq 1 ]    || { echo "ERROR: exactly one argument required" >&2; return 1; }
    [ -n "$1" ]       || { echo "ERROR: pattern must not be empty" >&2; return 1; }
    command -v fzf    || { echo "ERROR: fzf not found in PATH" >&2; return 1; }

    local pattern="$1"
    grep "$pattern" /data/old.filesystem.txt | fzf
}

# search if keybind apply or not?
# bindkey | grep '\[\[3~'
# (emacs keymap is forced early above via `bindkey -e`)


fdf() {
    local dir
    die() { printf 'fdf: %s\n' "$*" >&2; return 1; }

    [ "$#" -eq 1 ] || die "Usage: fdf <directory>"
    dir=$1
    [ -d "$dir" ] || die "Not a directory: $dir"

    fd -E venv -E .venv -E site-packages -E .git -E local-conf --max-depth 10 . "$dir"
}

function setdate(){
    timeout 2s curl -sI 1.1.1.1 >/dev/null 2>&1
    local _status=$?
    if [ $_status -eq 124 ];then
        echo "curl exist with $_status"; timeout 2s curl -sI 1.1.1.1
    elif [ $_status -ne 0 ];then 
        echo "curl exist with $_status"
    fi

    date="$(timeout 10s curl -sI 1.1.1.1 | grep -i ^date | cut -d' ' -f2- | tr -d '\r')"
    [ -n "$date" ] || { echo "date was empty";  return 1; }
    echo sudo date -s "$date"
    sudo date -s "$date"
}
