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
            background = colors.ui.secondaryAccent;
            foreground = colors.ui.darkText;
          };
        };
        active = {
          background = colors.ui.background;
          backgroundAlt = colors.ui.background;
          foreground = colors.ui.accentAlt;
          highlight = {
            background = colors.ui.accentAlt;
            foreground = colors.ui.foreground;
          };
        };
      };
    };
  };

  services.sxhkd.keybindings = {
    "mod1 + space" = "${pkgs.rofi}/bin/rofi -show drun -modi drun -display-drun \"Search\"";
    "mod1 + Tab" = "${pkgs.rofi}/bin/rofi -show window -modi window -display-window \"Window\" -me-accept-entry \"MousePrimary\" -me-select-entry \"MouseDPrimary\"";
  };
}
