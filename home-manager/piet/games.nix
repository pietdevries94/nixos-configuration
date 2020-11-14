{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ 
    steam
    discord
    minecraft
    lutris
  ];
}
