{ colors }:
{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
        TERM = "xterm-256color";
      };
      window.padding = {
        x = 6;
        y = 3;
      };
      font = {
        size = 10.0;
      };

      colors = {
        primary = {
          foreground = colors.ui.foreground;
          background = colors.ui.background;
        };

        normal = colors.normal;
        bright = colors.bright;
      };
    };
  };

  services.sxhkd.keybindings = {
    "mod3 + Return" = "alacritty";
  };
}
