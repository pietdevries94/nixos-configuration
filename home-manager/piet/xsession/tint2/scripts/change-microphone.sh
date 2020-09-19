#!/usr/bin/env bash

# Audio volume changer using alsa mixer
icon_name=$2

function cvol {
    amixer get Capture | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
}

function chkmute {
    amixer get Capture | grep '%' | grep -oE '[^ ]+$' | grep off
}

function notify {
    volume=`cvol`

    ~/.config/tint2/scripts/notify-send.sh -i "$icon_name" -t 2000 -r 125 "Microphone Volume" "On level $volume%"
}

case $1 in
    up)
	# Unmute
	if chkmute ; then
    amixer set Capture 1+ toggle > /dev/null
  fi
	# +5%
	amixer sset Capture 5%+ > /dev/null
	notify
	;;
    down)
    # Unmute
  if chkmute ; then
    amixer set Capture 1+ toggle > /dev/null
  fi
    # -5%
	amixer sset Capture 5%- > /dev/null
	notify
	;;
    mute)
    # Toggle mute
	amixer set Capture 1+ toggle > /dev/null
	if chkmute ; then
    ~/.config/tint2/scripts/notify-send.sh -i "$icon_name" -t 2000 -r 125 "Microphone Volume" "Muted"
	else
	    notify
	fi
	;;
esac
