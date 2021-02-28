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


#PATH
for d in $HOME/scripts/my/*; do
  PATH="$PATH:$d"
done
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin


export PATH


#delcheck "$@"
#tmux
# clear
# neofetch
#$HOME/start-void.sh
