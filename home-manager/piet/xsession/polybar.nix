{ colors }:
{ config, pkgs, lib, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
    };
    config = {
      "bar/top" = {
        font-0 = "inconsolata-nerdfont:size=10;2";
        font-1 = "siji:size=12;2";

        background = "#00000000";
        foreground = colors.ui.darkText;

        monitor = "\${env:MONITOR:}";
        height = 26;
        radius = 0;
        offset-y = 6;
        offset-x = 8;
        width = "100%:-16 ";

        fixed-center = true;
        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio";

        override-redirect = true;
        wm-restack = "i3";
        bottom = true;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        # format-volume = "<label-volume> <bar-volume>";
        format-volume = "<label-volume>";
        label-volume = "VOL %percentage%%";
        label-muted = "muted";
        label-volume-background = colors.ui.accent;
        label-muted-background = colors.ui.accent;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
        label-background = colors.ui.accent;
      };
      "module/i3" = {
        type = "internal/i3";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
        pin-workspaces = true;
        label-mode-background = colors.ui.accent;
        label-focused-background = colors.ui.accent;
        label-unfocused-background = colors.ui.accent;
        label-visible-background = colors.ui.accent;
        label-urgent-background = colors.ui.accent;
      };
    };
  };
}