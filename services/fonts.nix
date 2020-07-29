{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.allowBitmaps = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      curie
      siji.otb
      inconsolata-nerdfont
    ];
  };
}