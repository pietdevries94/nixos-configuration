{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.allowBitmaps = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      curie
      siji
      inconsolata-nerdfont
      font-awesome
      cantarell-fonts
    ];
  };
}