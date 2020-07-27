{ config, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  fonts = {
    fontconfig.allowBitmaps = true;
    enableDefaultFonts = true;
    fonts = [
      unstable.inconsolata-nerdfont
    ];
  };
}