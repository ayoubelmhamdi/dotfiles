#!/bin/bash
#  _________  _   _ ____   ____ 
# |__  / ___|| | | |  _ \ / ___|
#   / /\___ \| |_| | |_) | |    
#  / /_ ___) |  _  |  _ <| |___ 
# /____|____/|_| |_|_| \_\\____|
 

# source {{
  source $HOME/.config/myConfig/zsh-config
  source $ZSH/oh-my-zsh.sh
  source $HOME/.config/myConfig/isExcite
  source $HOME/.config/myConfig/path
  source $HOME/.config/myConfig/export
#}}

# My OS {{
    OS="Linux"
    . $HOME/.config/myConfig/this-distribution.sh
    . $HOME/.alias
#}}
# editor {{
    VISUAL="nvim"
    EDITOR="nvim"
#}}
# ANDROID SDK {{
# first you must update sdk and accepte licenses
# sdkmanager --sdk_root=${ANDROID_HOME} --version
# yes |
# sdkmanager --sdk_root=${ANDROID_HOME} --licenses 
# echo "sdk.dir=/data/data/com.termux/files/home/android-sdk" >> local.properties
# mkdir $HOME/android-sdk/
# dont do this in termux
# sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools"

#}}

# delcheck "$@"
# tmux
# clear
# neofetch
# $HOME/start-void.sh


#[[ -f $HOME/tt.log ]] && rm -rf $HOME/tt.log  >/dev/null 2>&1
