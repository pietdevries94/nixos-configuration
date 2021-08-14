{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.services.kdeconnect;
in {
  options.custom.user.services.kdeconnect = {
    enable = mkEnableOption "KDE Connect";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
