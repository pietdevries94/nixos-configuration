{ theme }:
{ config, pkgs, ... }:

{
  imports = [
    (import ./xsession/screen-locker.nix { colors = theme.colors; })
  ];

  home.packages = with pkgs; [ 
    barrier
    ferdi
    networkmanager-fortisslvpn
    networkmanager-openvpn
    azuredatastudio
  ];
}