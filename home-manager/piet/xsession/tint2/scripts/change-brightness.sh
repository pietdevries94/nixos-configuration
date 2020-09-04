#!/usr/bin/env bash

# options do be displayed
option0="0%"
option1="10%"
option2="20%"
option3="30%"
option4="40%"
option5="50%"
option6="60%"
option7="70%"
option8="80%"
option9="90%"
option10="100%"


# options passed to variable
options="$option0\n$option1\n$option2\n$option3\n$option4\n$option5\n$option6\n$option7\n$option8\n$option9\n$option10"

selected="$(echo -e "$options" | rofi -width 35 -lines 11 -dmenu -p "Brightness")"

# TODO: Make a mapping for my screens to match actual brightness
case $selected in
  $option0)
    screen1=0
    screen2=0
    ;;
  $option1)
    screen1=10
    screen2=10
    ;;
  $option2)
    screen1=20
    screen2=20
    ;;
  $option3)
    screen1=30
    screen2=30
    ;;
  $option4)
    screen1=40
    screen2=40
    ;;
  $option5)
    screen1=50
    screen2=50
    ;;
  $option6)
    screen1=60
    screen2=60
    ;;
  $option7)
    screen1=70
    screen2=70
    ;;
  $option8)
    screen1=80
    screen2=80
    ;;
  $option9)
    screen1=90
    screen2=90
    ;;
  $option10)
    screen1=100
    screen2=100
    ;;
  *)
    exit 0
  ;;
esac

sudo ddcutil -d 1 setvcp 10 $screen1 &
sudo ddcutil -d 2 setvcp 10 $screen2 &

~/.config/tint2/scripts/notify-send.sh -i "computer" -t 2000 -r 124 "Screen Brightness" "On level $selected"
