{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.work;
in {
  options.custom.setups.work = {
    enable = mkEnableOption "Programs used at work";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = with pkgs; [
        ferdi
        networkmanager-fortisslvpn
        networkmanager-openvpn
        azuredatastudio
        teams
        google-chrome
        libreoffice
        insomnia
        standardnotes
        glab
      ];
    };
  };
}