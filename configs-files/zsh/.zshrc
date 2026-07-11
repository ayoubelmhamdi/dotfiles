#!/bin/zsh



# if touch "/data" ; then
#   builtin cd /data
# elif touch "$HOME/data" ; then
#   builtin cd $HOME/data
# fi
#
if command -v zoxide >/dev/null 2>&1; then
    eval "$(starship init zsh &)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh &)"
fi

fpath=(~/.config/fpath $fpath)

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


##############################################
# SETOPT

# Do not trigger filename/glob errors when there is no match.
# Makes zsh behave more like bash (leaves patterns unchanged).
# Useful for using '?' in URLs, etc.
# Example:
#   $ echo a?=3
#   a?=3
setopt NO_NOMATCH

unsetopt beep         #turn off bell
unsetopt list_beep
set bell-style none

setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt extended_history       # add time to zshhistory like `:1659681839:0;cat hist`
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_ignore_all_dups   # ignore duplicated commands history list


export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

export LISTMAX=20             # Number of completions shown w/o asking
export TIMEFMT=$TIMEFMT       # Format for reporting usage with time
export WATCHFMT=$WATCHFMT     # Format of reports for $watch


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




####################################
#2# kitty
#2
#2zmodload -i zsh/parameter
#2
#2insert-last-command-output() {
#2  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
#2}
#2zle -N insert-last-command-output
#2
#2# only kitty that have tab and ctrl+i different: but not easy to figureout, so no terminal agnositc keybinds.
#2bindkey "\e[105;5u" insert-last-command-output # ctrl + I
#2bindkey "^I"        insert-last-command-output # ctrl + I (maybe kitty)



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
unalias ls 2>/dev/null


if [[ -s $HOME/.config/zsh  ]];then
    for file in $HOME/.config/zsh/* $HOME/.config/zsh-post/*;do
        zi ice lucid wait
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

run_claude(){
    local token head_token t found
    init_claude_json='
    {
     "customApiKeyResponses": {
       "approved": [
         "8abad0a08c62d5c01c0a",
         "bd59d2a85ceeb76f78f7",
         "b07c5b66bd8a8b36f7dd",
         "ee6848507d1bc80de014"
       ]
     },
     "hasCompletedOnboarding": true
    }'

    init_claude_user_json='
    {
      "permissions": {
        "allow": [
          "Read(./local-conf/**)",
          "Bash(echo \"exit=$?\")",
          "Bash(curl *)",
          "Bash(find *)",
          "Bash(curl /Users/dev/*)",
          "Bash(./venv/bin/python3.11 *)",
          "Bash(* --version)",
          "Bash(* --help *)",
          "Bash(jq:*)",
          "Bash(rm -rf build)",
          "Bash(ruff check:*)",
          "Bash(go build *)",
          "Bash(make:*)"
        ],
        "deny": [
          "Bash(ruff format:*)",
          "Bash(chmod *)",
          "Bash(curl * | bash)",
          "Bash(wget * | bash)",
          "Bash(git push *)",
          "Read(.envrc)",
          "Read(.env)",
          "Read(.env.*)",
          "Read(./secrets/**)",
          "Read(./**/*.key)",
          "Read(./**/*.pem)",
          "Read(./**/credentials.*)"
        ],
        "ask": []
      },
      "statusLine": {
        "type": "command",
        "command": "bash /home/mhamdi/.claude/statusline.sh",
        "padding": 0
      }
    }

    '

    tokens_name=(
        "78f7" # abdo1
        "1c0a" # pcayoub1@gmail.com
        "f7dd" # abdo2
        "e014" # smp.ayoub@gmail.com 
    )
    [ $# -ne 0 ] || { echo "ERROR: no arg provided" >&2; return 1; }
    token="$1";shift

    head_token="${token:50}"
    [ "${#token}" -eq 54 ] || { echo "api $head_token... length ${#token} not 54 char" >&2; return 1; }
    # associative array not work in bash and zsh in the same way.
    # so normal loop are enaugh to me.
    found=0
    for t in "${tokens_name[@]}"; do
        [ "$t" = "$head_token" ] && { found=1; break; }
    done
    [ "$found" -eq 1 ] || { echo "first 10 head token '$head_token' doesn't exist in \$tokens_name" >&2; return 1; }


    mkdir -p ./local-conf || { echo "can not create ./local-conf/." >&2; return 1; }

    args=()
    if [ -f local-conf/.claude.json ];then
          cwd_slug=$(printf '%s' "$(builtin pwd -P)" | tr -c 'a-zA-Z0-9' '-')
          [ -d "./local-conf/projects/$cwd_slug" ] || {
              echo "check if old projects names cot correct:"
              echo "try: "
              echo "mv" "./local-conf/projects/"*"/" "./local-conf/projects/$cwd_slug/"
              return 1
          }
          args+=( --continue )
    else
        # echo "$init_claude_json" to ./local-conf/.claude.json 
        echo "$init_claude_json" > ./local-conf/.claude.json || {
            echo "can not create ./local-conf/.claude.json" >&2
            return 1
        }

        # echo "$init_claude_user_json" to ./local-conf/settings.json 
        echo "$init_claude_user_json" > ./local-conf/settings.json || {
            echo "can not create ./local-conf/settings.json" >&2
            return 1
        }

    fi


    ANTHROPIC_API_KEY="$token"                                     \
    ANTHROPIC_BASE_URL="https://cc.freemodel.dev"                  \
                                                                   \
    ANTHROPIC_TOKEN_NAME="$head_token"                             \
    CLAUDE_CONFIG_DIR=./local-conf                                 \
                                                                   \
    claude "${args[@]}" "$@"
}


# search if keybind apply or not?
# bindkey | grep '\[\[3~'
# (emacs keymap is forced early above via `bindkey -e`)
