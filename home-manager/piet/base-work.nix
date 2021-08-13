{ theme }:
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    barrier
    ferdi
    networkmanager-fortisslvpn
    networkmanager-openvpn
    azuredatastudio
    teams
    google-chrome
    libreoffice
    insomnia
    standardnotes
    kazam
    handbrake
    glab
  ];
}