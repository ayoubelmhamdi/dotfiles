#!/bin/bash
# _________  _   _ 
#|__  / ___|| | | |
#  / /\___ \| |_| |
# / /_ ___) |  _  |
#/____|____/|_| |_|
                  
export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="macovsky-ruby"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

##alias by OS
## source {{
    OS="Linux"
    . $HOME/.config/myConfig/this-distribution.sh
    . $HOME/.alias

##}}


## editor {{
    VISUAL="nvim"
    EDITOR="nvim"
##}}

#  ____   _  _____ _   _ 
# |  _ \ / \|_   _| | | |
# | |_) / _ \ | | | |_| |
# |  __/ ___ \| | |  _  |
# |_| /_/   \_\_| |_| |_|
                       
#my scripts and sub directory
for directory in $HOME/scripts/my/*/ ; do
  PATH="$PATH:$directory"
done
[[ -d $HOME/scripts/my ]] && PATH=$PATH:$HOME/scripts/my


#run arch in termux
[[ -d $HOME/arch ]] && PATH=$PATH:$HOME/arch


# run open-url/open file in termux
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin


# apps:python...
[[ -d $HOME/.local/bin ]] && PATH=$PATH:$HOME/.local/bin
#java termux
[[ -d $PREFIX/jdk/lib ]] && PATH=$PATH:$PREFIX/jdk/lib
[[ -d $PREFIX/jdk/lib/jli ]] && PATH=$PATH:$PREFIX/jdk/lib/jli
# android sdk
[[ -d $HOME/sdk/android-sdk/tools/bin ]] && PATH=$PATH:$HOME/sdk/android-sdk/tools/bin
[[ -d $HOME/gradle-6.6.1/bin ]] && PATH=$PATH:$HOME/gradle-6.6.1/bin
# gitm7x for git in tmux
[[ -d $HOME/.config/myConfig/gitmux ]] && PATH=$PATH:$HOME/.config/myConfig/gitmux
# new sdk
# PATH:${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin
# [[ -d  ]] && PATH:${ANDROID_HOME}/platform-tools

#remove duplique path
PATH=$(printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')

# _______  ______   ___  ____ _____ 
#| ____\ \/ /  _ \ / _ \|  _ \_   _|
#|  _|  \  /| |_) | | | | |_) || |  
#| |___ /  \|  __/| |_| |  _ < | |  
#|_____/_/\_\_|    \___/|_| \_\|_|  
                                   
export PATH
[[ -d $HOME/.local/share ]] && export XDG_DATA_HOME=$HOME/.local/share

# JAVA_HOME
[[ -d $PREFIX/jdk ]] && export JAVA_HOME=$PREFIX/jdk
[[ -d $PREFIX/jdk/lib:$PREFIX/jdk/lib/jli ]] && export LD_LIBRARY_PATH=$PREFIX/jdk/lib:$PREFIX/jdk/lib/jli
# GRADLE_USER_HOME
[[ -d $HOME/gradlec ]] && export GRADLE_USER_HOME=$HOME/gradlec


# sdk
# export ANDROID_HOME=$HOME/sdk/android-sdk

# if licenses not setup yet exec one time 
# yes | $HOME/sdk/android-sdk/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# not work yet 
# $HOME/sdk/android-sdk/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null

#delcheck "$@"
#tmux
# clear
# neofetch
#$HOME/start-void.sh
#
#

## new sdk
## export ANDROID_HOME=$HOME/sdk/android-sdk
## export PATH=$PATH:${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/
## export PATH=$PATH:${ANDROID_HOME}/platform-tools
#
#
#
[[ -f $HOME/tt.log ]] && rm -rf $HOME/tt.log  >/dev/null 2>&1
