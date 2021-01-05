#!/usr/bin/env nix-shell
#!nix-shell -i bash -p xdotool
  
pids=$(xdotool search --class wtfutilterm)
if [[ ${#pids[@]} -eq 1 && ${pids[0]} == "" ]]; then
  alacritty --class wtfutilterm,wtfutilterm --command wtfutil &
  exit 0
fi

for pid in $pids; do
	bspc node $pid --flag hidden -t fullscreen -f
done