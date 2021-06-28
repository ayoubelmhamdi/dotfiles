#!/bin/bash


# dpi and font
# xrdb -merge ~/.Xresource
xrdb - merge -I$HOME ~/.Xresources
#xmodmap -pke | grep Alt_R
xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
exec nitrogen --restore &
exec alacritty &
exec firefox 
~/scripts/suckless/dwm-ayoub/ayoubStatusBar.sh &
sxhkd &

# Map CapsLock to shift
xmodmap -e "keycode 66 = Shift_L NoSymbol Shift_L"
xmodmap -e "keycode 166 = Prior"
xmodmap -e "keycode 167 = Next"

while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
