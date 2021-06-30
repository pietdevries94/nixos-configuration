{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.libinput-gestures pkgs.xdotool ];
  
  home.file.".config/libinput-gestures.conf".source = pkgs.writeText "libinput-gestures.conf" ''
gesture swipe up	3 xdotool key alt+Tab
gesture swipe down	3 xdotool key Escape

# Front and back
gesture swipe left	3 xdotool key alt+Right
gesture swipe right	3 xdotool key alt+Left

# Notifications
gesture swipe up	4 xdotool key ctrl+space
gesture swipe down	4 xdotool key ctrl+Escape

# Zoom in and out
gesture pinch in	xdotool key ctrl+equal
gesture pinch out	xdotool key ctrl+minus
'';

  xsession.initExtra = ''
    libinput-gestures &
  '';
}