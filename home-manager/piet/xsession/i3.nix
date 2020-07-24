{ config, pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec i3-sensible-terminal";
        "${modifier}+Shift+q" = "kill";
        "Mod4+space" = "exec ${pkgs.rofi}/bin/rofi -show drun -modi drun";
      };

      window.border = 4;
      floating.border = 4;

      gaps = {
        inner = 16;
        outer = 0;
      };

      bars = [];

      startup = [
        { command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png"; always = true; notification = false; }
      ];
    };
  };

  home.file.".background-image.png".source = "/etc/nixos/home-manager/piet/wallpapers/Autumn-cropped.png";
}