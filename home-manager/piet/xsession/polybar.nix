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
        font-0 = "curie:size=8;2";
        font-1 = "siji:size=12;2";

        background = "#444444";
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "3%";
        radius = 0;
        # Just sticking them together in the center for now
        modules-left = "i3";
        modules-right = "pulseaudio date";
        # override-redirect = true;
        # wm-restack = "i3";
        # bottom = true;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        # format-volume = "<label-volume> <bar-volume>";
        format-volume = "<label-volume>";
        label-volume = "VOL %percentage%%";
        label-muted = "muted";
        label-volume-background = "#000000";
        label-muted-background = "#000000";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
        label-background = "#000000";
      };
      "module/i3" = {
        type = "internal/i3";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
        pin-workspaces = true;
        label-mode-background = "#000000";
        label-focused-background = "#000000";
        label-unfocused-background = "#000000";
        label-visible-background = "#000000";
        label-urgent-background = "#000000";
      };
    };
  };
}