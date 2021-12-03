{ colors }:
{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
  };

  services.sxhkd.keybindings = {
    "mod1 + space" = "${pkgs.rofi}/bin/rofi -show drun -modi drun -display-drun \"Search\" -show-icons";
    "mod1 + Tab" = "${pkgs.rofi}/bin/rofi -show window -modi window -display-window \"Window\" -me-accept-entry \"MousePrimary\" -me-select-entry \"MouseDPrimary\" -show-icons";
  };
}
