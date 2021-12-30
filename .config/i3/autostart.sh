#!/bin/bash -l


# Set desktop background
feh --bg-scale --no-fehbg $HOME/Pictures/astronaut.jpg &
# Launch polybar
sh $HOME/.config/polybar/launch.sh &
# Start compositor
xcompmgr -c -l0 -t0 -r0 -o.00 &
# Launch networkmanager applet for wifi
nm-applet &
# Set X window property
xset r rate 250 25 &
# Launch caffeine applet
caffeine start &
# Screenlock
#xss-lock --transfer-sleep-lock -- i3lock --nofork &
# Dunst
dunst -conf $HOME/.config/dunst/dunstrc &

# Automatically mount USBs
if [[ -z $(pgrep "udiskie") ]];
then
    udiskie --smart-tray &
fi
