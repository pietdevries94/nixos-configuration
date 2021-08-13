{ lib, pkgs, config, ... }:
with lib;

# colors scheme from https://gitlab.com/horizon/horizon-vscode/-/blob/master/source/light/colors.json
let
  colors = {
    normal = {
      black = "#06060C";
      white = "#FADAD1";
      blue = "#26BBD9";
      cyan = "#59E1E3";
      green = "#29D398";
      magenta = "#EE64AC";
      red = "#E95678";
      yellow = "#FAB795";
    };
    bright = {
      black = "#817b7c";
      white = "#FDF0ED";
      blue = "#3FC4DE";
      cyan = "#6BE4E6";
      green = "#3FDAA4";
      magenta = "#F075B5";
      red = "#EC6A88";
      yellow = "#FBC3A7";
    };
    syntax = {
      amethyst = "#8A31B9";
      crimson = "#DA103F";
      elm = "#1D8991";
      thunderbird = "#DC3318";
      tango = "#F6661E";
      jaffa = "#F77D26";
      black = "#333333";
    };
    ui = rec {
      shadow = "#16161C";
      border = "#1A1C23";
      background = "#FDF0ED";
      backgroundAlt = "#FADAD1";
      accent = "#F9CBBE";
      accentAlt = "#F9CEC3";
      secondaryAccent = "#E73665";
      secondaryAccentAlt = "#E84A72";
      tertiaryAccent = "#AF5427";
      positive = "#07DA8C";
      negative = "#F43E5C";
      warning = "#1EB980";
      modified = "#1EAEAE";
      lightText = "#D5D8DA";
      darkText = "#06060C";
      foreground = "#06060C";
      foregroundAlt = "#817b7c";
    };
  };

  cfg = config.custom.themes.horizon-light;
in {
  options.custom.themes.horizon-light = {
    enable = mkEnableOption "Horizon Light Theme";
    name = mkOption {
      type = types.path;
      default = ./sky.jpg;
    };
  };

  config = mkIf cfg.enable {
    custom.user = {
      programs = {
        alacritty.colors = colors;
        vscode.theme = {
          extension = pkgs.extra-vscode-extensions.Bauke.horizon-vscode;
          name = "Horizon Light";
        };
      };
      xsession = {
        screen-locker.colors = colors;
      };
    };
  };
}

#   home.file.".config/BetterDiscord/themes/Horizon.theme.css".source = pkgs.writeText "Horizon.theme.css" ''
# /**
#  * @name Horizon
#  * @description Allows you to customize Discord's native Color Scheme
#  * @author DevilBro
#  * @version 1.0.0
#  * @authorId 278543574059057150
#  * @invite Jx3TjNS
#  * @donate https://www.paypal.me/MircoWittrien
#  * @patreon https://www.patreon.com/MircoWittrien
#  * @website https://mwittrien.github.io/
#  * @source https://github.com/mwittrien/BetterDiscordAddons/tree/master/Themes/DiscordRecolor/
#  * @updateUrl https://mwittrien.github.io/BetterDiscordAddons/Themes/DiscordRecolor/DiscordRecolor.theme.css
# */

# @import url('https://fonts.googleapis.com/css2?family=:wght@100;300;400;500;700&display=swap');
# @import url('https://mwittrien.github.io/BetterDiscordAddons/Themes/DiscordRecolor/DiscordRecolor.css');

# :root {
#   --accentcolor: 236,106,136;
#   --accentcolor2: 175,84,39;
#   --linkcolor: 244,62,92;
#   --mentioncolor: 251,195,167;
#   --textbrightest: 6,6,12;
#   --textbrighter: 43,41,46;
#   --textbright: 61,59,62;
#   --textdark: 86,82,85;
#   --textdarker: 111,105,107;
#   --textdarkest: 129,123,124;
#   --font: 'Whitney';
#   --backgroundaccent: 249,203,190;
#   --backgroundprimary: 253,240,237;
#   --backgroundsecondary: 250,218,209;
#   --backgroundsecondaryalt: 249,203,190;
#   --backgroundtertiary: 249,203,190;
#   --backgroundfloating: 253,240,237;
#   --settingsicons: 1;
# '';