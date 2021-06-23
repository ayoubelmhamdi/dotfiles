#!/bin/bash

# cd to folder by name of files


cdd() {
 export FZF_DEFAULT_OPTS='--height=95% '
 cd  $(                             \
    fd --type d                     \
       --hidden                     \
       --follow                     \
       --exclude "dotfiles"         \
       --exclude ".git"             \
       --exclude ".npm"             \
       --exclude ".cache" . | fzf)  
  clear
  $PREFIX/bin/exa 
  printf "\033[1;4;35m%-${COLUMNS}s\033[00m"
  echo " "
 export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'
}

cff() {
 pushd $(dirname $(fd --type f          \
       --hidden                         \
       --follow                         \
       --exclude "dotfiles"             \
       --exclude ".git"                 \
       --exclude ".local"                 \
       --exclude ".npm"                 \
       --exclude ".cache" . | fzf ))
  clear
  $PREFIX/bin/exa 
  printf "\033[1;4;35m%-${COLUMNS}s\033[00m"
  echo " "
}

findAppInXbps(){
    clear
    sudo xbps-query -Rs $1 |awk '{print $2}'|sed  's/-[0-9,_.]*$//'   # find pkg
}
