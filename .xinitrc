#!/bin/bash

# ---[Autostart applications]--- #
~/.fehbg &
# sct 2800 &
dwmblocks &
greenclip daemon &
/usr/lib/kdeconnectd &
/usr/bin/lxqt-policykit-agent &
picom --experimental-backends &
xrdb -merge ~/.Xresources &
xautolock -time 15 -locker ~/.config/bin/lock.sh &
brightnessctl set $(cat $HOME/.config/bin/.luz) &
amixer sset 'Master' $(cat $HOME/.config/bin/.audio) &
amixer sset 'Capture' $(cat $HOME/.config/bin/.microphone) &
bluetoothctl power $(cat $HOME/.config/bin/.on:off) ; pkill -RTMIN+9 dwmblocks &

exec dwm
