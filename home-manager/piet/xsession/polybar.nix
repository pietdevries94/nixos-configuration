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
        offset-y = 10;
        offset-x = 16;
        width = "100%:-32 ";

        fixed-center = true;
        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio tempcpu tempwifi tempamdgpu filesystem memory cpu";

        override-redirect = true;
        wm-restack = "i3";
        bottom = true;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        # format-volume = "<label-volume> <bar-volume>";
        format-volume = "<label-volume>";
        label-volume = " VOL %percentage%%";
        label-muted = " muted";
        label-volume-background = colors.ui.accent;
        label-muted-background = colors.ui.accent;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = " %date% %time% ";
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
      "module/memory" = {
        type = "internal/memory";
        label-background = colors.ui.accent;
        label = " | ram %gb_used%";
      };
      "module/cpu" = {
        type = "internal/cpu";
        label-background = colors.ui.accent;
        label = " | cpu %percentage%% ";
      };
      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        label-mounted-background = colors.ui.accent;
        label-mounted = " | / %percentage_used%%";
      };
      "module/tempcpu" = {
        type = "internal/temperature";
        hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input";
        label = " | cpu %temperature-c%";
        label-background = colors.ui.accent;
      };
      "module/tempwifi" = {
        type = "internal/temperature";
        hwmon-path = "/sys/devices/virtual/thermal/thermal_zone0/hwmon2/temp1_input";
        label = " | wifi %temperature-c%";
        label-background = colors.ui.accent;
      };
      "module/tempamdgpu" = {
        type = "internal/temperature";
        hwmon-path = "/sys/devices/pci0000:00/0000:00:03.1/0000:0b:00.0/hwmon/hwmon3/temp1_input";
        label = " | gpu %temperature-c%";
        label-background = colors.ui.accent;
      };
    };
  };
}