#!/usr/bin/env bash

# Audio volume changer using alsa mixer
icon_name="applications-multimedia"

function cvol {
    amixer get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
}

function chkmute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off
}

function notify {
    volume=`cvol`

    ~/.config/tint2/scripts/notify-send.sh -i "$icon_name" -t 2000 -r 123 "Media Volume" "On level $volume%"
}

case $1 in
    up)
	# Unmute
	amixer set Master on > /dev/null
	# +5%
	amixer sset Master 5%+ > /dev/null
	notify
	;;
    down)
    # Unmute
	amixer set Master on > /dev/null
    # -5%
	amixer sset Master 5%- > /dev/null
	notify
	;;
    mute)
    # Toggle mute
	amixer set Master 1+ toggle > /dev/null
	if chkmute ; then
    ~/.config/tint2/scripts/notify-send.sh -i "$icon_name" -t 2000 -r 123 "Media Volume" "Muted"
	else
	    notify
	fi
	;;
esac
