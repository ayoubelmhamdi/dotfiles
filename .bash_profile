#!/bin/bash
 #.  ~/.profile
 # .  ~/.xinitrc
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx
  # Could use xinit instead of startx
  #exec xinit -- /usr/bin/X -nolisten tcp vt7
fi



clear


# . $HOME/.config/myConfig/myOS
# . $HOME/.config/myConfig/my_alias

# . $HOME/.config/myConfig/isExcite
# . $HOME/.config/myConfig/all_PATH
# . $HOME/.config/myConfig/export_Linux
# . $HOME/.config/myConfig/export_Dirs



# for i in {1..3}; do
#     clear
#     echo -e "\n\n\t\t" $i 
#     sleep 0.2 &
# done
clear && echo -e "\n\n\n\t\t\tTermux" 
exec zsh 
#exit
