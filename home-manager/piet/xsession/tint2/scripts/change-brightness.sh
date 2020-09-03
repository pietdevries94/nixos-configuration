#!/usr/bin/env bash

icon_name="audio-headset"

function cbr {
    sudo ddcutil -d 1 getvcp 10 | sed -n "s/.*current value = *\([^']*\), max value =   100.*/\1/p"
}
old=`cbr`
new=100
if [ $old -eq 100 ]; then
  new=0
fi

sudo ddcutil -d 1 setvcp 10 $new &
sudo ddcutil -d 2 setvcp 10 $new &

~/.config/tint2/scripts/notify-send.sh -i "computer" -t 2000 -r 123 "Screen Brightness" "On level $new%"
