{ config, pkgs, ... }:

{
  imports = [
    (import ./xsession/screen-locker.nix { inherit colors; })
  ];

  home.packages = with pkgs; [ 
    barrier
    ferdi
    networkmanager-fortisslvpn
    networkmanager-openvpn
    azuredatastudio
  ];
}