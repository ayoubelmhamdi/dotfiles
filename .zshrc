#!/bin/bash
#  _________  _   _ ____   ____ 
# |__  / ___|| | | |  _ \ / ___|
#   / /\___ \| |_| | |_) | |    
#  / /_ ___) |  _  |  _ <| |___ 
# /____|____/|_| |_|_| \_\\____|
  

# source {{
. $HOME/.config/myConfig/isExcite
. $HOME/.config/myConfig/zsh_config
. $ZSH/oh-my-zsh.sh
. $HOME/.config/myConfig/myOS


. $HOME/.config/myConfig/all_PATH
. $HOME/.config/myConfig/export_Linux
. $HOME/.config/myConfig/export_Dirs

. $HOME/.config/myConfig/my_alias
. $HOME/.config/myConfig/my_function

#}}


# editor {{
    VISUAL="nvim"
    EDITOR="nvim"
#}}


# ANDROID SDK {{
# 
# cmdline-tools /4.0 ==>  you can't rename this folder to Anothername
# also you must locate under $ANDROID_HOME
# first you must and accepte licenses
# yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses 
# sdkmanager --sdk_root=${ANDROID_HOME} --version
# echo "sdk.dir=${PREFIX}/android-sdk" >> local.properties
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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/root/.sdkman"
[[ -s "/root/.sdkman/bin/sdkman-init.sh" ]] && source "/root/.sdkman/bin/sdkman-init.sh"

alias luamake=/tmp/oooop/lua-language-server/3rd/luamake/luamake
