{ colors }:
{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    separator = "solid";
    colors = {
      window = {
        background = colors.ui.background;
        border = colors.ui.tertiaryAccent;
        separator = colors.ui.tertiaryAccent;
      };

      rows = {
        normal = {
          background = colors.ui.background;
          backgroundAlt = colors.ui.background;
          foreground = colors.ui.foreground;
          highlight = {
            background = colors.ui.tertiaryAccent;
            foreground = colors.ui.darkText;
          };
        };
      };
    };
  };

  services.sxhkd.keybindings = {
    "super + space" = "${pkgs.rofi}/bin/rofi -show drun -modi drun -display-drun \"Search\"";
  };
}
