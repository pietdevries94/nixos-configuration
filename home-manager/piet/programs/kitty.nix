{ colors }:
{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Inconsolata Nerd Font";
      font_size = "10.0";
      window_padding_width = 4;
      enable_audio_bell = "no";

      foreground = colors.ui.darkText;
      background = colors.ui.background;

      selection_foreground = colors.ui.darkText;
      selection_background = colors.ui.backgroundAlt;

      mark1_foreground = colors.ui.darkText;
      mark1_background = colors.ui.accent;
      mark2_foreground = colors.ui.darkText;
      mark2_background = colors.ui.secondaryAccent;
      mark3_foreground = colors.ui.darkText;
      mark3_background = colors.ui.tertiaryAccent;

      color0 = colors.normal.black;
      color8 = colors.bright.black;
      color1 = colors.normal.red;
      color9 = colors.bright.red;
      color2  = colors.normal.green;
      color10 = colors.bright.green;
      color3  = colors.normal.yellow;
      color11 = colors.bright.yellow;
      color4  = colors.normal.blue;
      color12 = colors.bright.blue;
      color5  = colors.normal.magenta;
      color13 = colors.bright.magenta;
      color6  = colors.normal.cyan;
      color14 = colors.bright.cyan;
      color7  = colors.normal.white;
      color15 = colors.bright.white;
    };
  };
}
