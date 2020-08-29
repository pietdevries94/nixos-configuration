{ config, pkgs, lib, ... }:

{
  services.sxhkd = {
    enable = true;

    keybindings = {
      "super + space" = "${pkgs.rofi}/bin/rofi -show drun -modi drun";
      "mod3 + Return" = "kitty";
    };
  };
}