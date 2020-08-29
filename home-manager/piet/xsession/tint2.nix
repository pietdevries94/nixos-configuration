{ colors }:
{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    tint2
  ];
}
