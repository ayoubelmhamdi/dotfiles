export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="macovsky-ruby"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# source {{
    OS="Linux"
    . $HOME/.config/myConfig/this-distribution.sh
    . $HOME/.alias

#}}

VISUAL="nvim"


####################
#      PATH        #
####################

for directory in $HOME/scripts/my/*/ ; do
  PATH="$PATH:$directory"
done
PATH=$PATH:$HOME/scripts/my/
PATH=$PATH:$HOME/bin/
PATH=$PATH:$HOME/.local/bin/
PATH=$(printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
export PATH


echo       "\n"      > path.txt
echo -e "$PATH" >> path.txt
#delcheck "$@"
#tmux
# clear
# neofetch
#$HOME/start-void.sh
