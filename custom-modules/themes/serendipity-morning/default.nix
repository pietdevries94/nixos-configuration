{ lib, pkgs, config, ... }:
with lib;

# colors scheme from https://raw.githubusercontent.com/Serendipity-Theme/windows-terminal/main/schemes.jsonc
let
  colors = {
    normal = {
      black = "#F2E9DE";
      white = "#575279";
      blue = "#3788BE";
      cyan = "#7397DE";
      green = "#77AAB3";
      magenta = "#886CDB";
      red = "#D26A5D";
      yellow = "#C8A299";
    };
    bright = {
      black = "#6E6A86";
      white = "#575279";
      blue = "#3788BE";
      cyan = "#7397DE";
      green = "#77AAB3";
      magenta = "#886CDB";
      red = "#D26A5D";
      yellow = "#C8A299";
    };
    ui = rec {
      shadow = "#8388AD";
      border = "#5F6488";
      background = "#FDFDFE";
      backgroundAlt = "#F1F1F4";
      accent = "#D26A5D";
      accentAlt = "#F19A8E";
      secondaryAccent = "#886CDB";
      secondaryAccentAlt = "#7397DE";
      tertiaryAccent = "#77AAB3";
      positive = "#77AAB3";
      negative = "#D26A5D";
      warning = "#F19A8E";
      modified = "#3788BE";
      lightText = "#5F6488";
      darkText = "#4E5377";
      foreground = "#4E5377";
      foregroundAlt = "#5F6488";
    };
  };

  iconTheme = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir-manjaro";
  };

  cfg = config.custom.themes.serendipity-morning;
in {
  options.custom.themes.serendipity-morning = {
    enable = mkEnableOption "Serendipity Morning Theme";
    wallpaper = mkOption {
      type = types.path;
      default = ./wallpaper.jpg;
    };
  };

  config = mkIf cfg.enable {
    custom.user = {
      programs = {
        alacritty.colors = colors;
        vscode.theme = {
          extension = pkgs.extra-vscode-extensions.wicked-labs.wvsc-serendipity;
          name = "Serendipity Morning";
        };
        spotify.colorScheme = "white";
      };
      xsession = {
        base = {
          wallpaper = cfg.wallpaper;
          volumeIcon = "audio-headphones";
          gtkTheme = {
            inherit iconTheme;
            theme = {
              package = pkgs.qogir-theme;
              name = "Qogir-manjaro-light";
            };
          };
        };
        bspwm.colors = colors;
        awesome.colors = colors;
        rofi.theme = "Arc";
        screen-locker.colors = colors;
        picom.inactiveOpacity = "0.8";
        dunst = {
          inherit colors iconTheme;
        };
        tint2 = {
          inherit colors;
          scriptIcons = {
            brightness = "default-user-desktop";
            outputVolume = "audio-headphones";
            inputVolume = "audio-input-microphone";
          };
        };
      };
    };
  };
}
