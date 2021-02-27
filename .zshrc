export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="macovsky-ruby"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
source $HOME/.alias

export TERM=xterm-256color
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
