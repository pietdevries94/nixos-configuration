{ config, pkgs, ... }:

{
    home.packages = with pkgs; [ 
      barrier
      ferdi
      networkmanager-fortisslvpn
      networkmanager-openvpn
      azuredatastudio
    ];
}