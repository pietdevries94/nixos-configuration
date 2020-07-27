{ config, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
  personal = import <personal> {};
in
{
  fonts = {
    fontconfig.allowBitmaps = true;
    enableDefaultFonts = true;
    fonts = [
      personal.curie
      unstable.siji.otb
      unstable.inconsolata-nerdfont
    ];
  };
}