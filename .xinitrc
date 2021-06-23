#!/bin/bash



#xmodmap -pke | grep Alt_R
xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
exec nitrogen --restore &
exec alacritty &
exec firefox &
~/scripts/suckless/dwm-ayoub/ayoubStatusBar.sh &


while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
