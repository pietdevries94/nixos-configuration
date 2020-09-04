#!/usr/bin/env bash

# options do be displayed
option0="Logout"
option1="Shutdown"
option2="Reboot"

# options passed to variable
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 11 -width 35 -dmenu -p "Power")"

case $selected in
  $option0)
    bspc quit
    ;;
  $option1)
    sudo shutdown now
    ;;
  $option2)
    sudo reboot
    ;;
esac