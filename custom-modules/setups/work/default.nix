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
      5173
    ];

    services.logind.extraConfig = "RuntimeDirectorySize = 40%";
    services.teamviewer.enable = true;

    programs.adb.enable = true;
    users.users.piet.extraGroups = ["adbusers"];
    security.pki.certificates = [ (builtins.readFile /home/piet/.local/share/mkcert/rootCA.pem) ];
    
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    home-manager.users.piet = {
      home.packages = with pkgs; [
        ferdium
        networkmanager-fortisslvpn
        networkmanager-openvpn
        #azuredatastudio
        teams
        google-chrome
        libreoffice
        postman
        standardnotes
        glab
        mkcert
        microsoft-edge
        flameshot
      ];

    xsession.initExtra = ''
      flameshot &
    '';
    };
  };
}
