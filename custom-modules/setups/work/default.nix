{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.work;
in {
  options.custom.setups.work = {
    enable = mkEnableOption "Programs used at work";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      # Webdev stuff
      8080
      18081
      18881
    ];

    services.logind.extraConfig = "RuntimeDirectorySize = 40%";
    services.teamviewer.enable = true;

    programs.adb.enable = true;
    users.users.piet.extraGroups = ["adbusers"];
    
    home-manager.users.piet = {
      home.packages = with pkgs; [
        ferdi
        networkmanager-fortisslvpn
        networkmanager-openvpn
        azuredatastudio
        teams
        google-chrome
        libreoffice
        postman
        standardnotes
        glab
      ];
    };
  };
}
