{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    discord
    betterdiscordctl
    minecraft
    lutris
  ];
}
