{ colors }:
{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    tint2
  ];

  xsession.initExtra = ''
    tint2 &
    blueman-applet &
  '';
}
