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

#my scripts and sub directory
PATH=$PATH:$HOME/scripts/my/
for directory in $HOME/scripts/my/*/ ; do
  PATH="$PATH:$directory"
done

PATH=$PATH:$HOME/arch/
PATH=$PATH:$HOME/bin/
PATH=$PATH:$HOME/.local/bin/
#java
PATH=$PATH:$PREFIX/jdk/lib
PATH=$PATH:$PREFIX/jdk/lib/jli/
# android sdk
PATH=$PATH:$HOME/sdk/android-sdk/tools/bin
PATH=$PATH:$HOME/gradle-6.6.1/bin
#remove duplique path
PATH=$(printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
export PATH

# JAVA_HOME
export JAVA_HOME=$PREFIX/jdk
export LD_LIBRARY_PATH=$PREFIX/jdk/lib:$PREFIX/jdk/lib/jli/
# GRADLE_USER_HOME
export GRADLE_USER_HOME=$HOME/gradlec


# sdk
export ANDROID_HOME=$HOME/sdk
# if licenses not setup yet exec one time 
# yes | $HOME/sdk/android-sdk/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# not work yet 
# $HOME/sdk/android-sdk/tools/bin/sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null

#delcheck "$@"
#tmux
# clear
# neofetch
#$HOME/start-void.sh
