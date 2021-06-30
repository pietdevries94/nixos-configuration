{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ 
    steam
    discord
    betterdiscordctl
    minecraft
    lutris
  ];
}
