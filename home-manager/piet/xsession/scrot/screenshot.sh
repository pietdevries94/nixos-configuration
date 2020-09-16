#!/usr/bin/env nix-shell
#!nix-shell -i bash -p scrot xclip

case $1 in
  full)
scrot -o -e 'xclip -selection c -t image/png < $f' /tmp/screenshot-temp.png
  ;;
  selection)
scrot -sof -e 'xclip -selection c -t image/png < $f' /tmp/screenshot-temp.png
  ;;
esac

rm -f /tmp/screenshot-temp.png