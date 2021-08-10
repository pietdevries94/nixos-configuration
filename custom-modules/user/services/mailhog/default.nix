{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.services.mailhog;
in {
  options.custom.user.services.mailhog = {
    enable = mkEnableOption "Service for a simple SMTP sandbox";
    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, Mailhog will start when the user logs in
      '';
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      systemd.user.services.mailhog = {
        Unit = {
          Description = "MailHog service";
        };
        
        Service = {
          ExecStart = "${pkgs.mailhog}/bin/MailHog";
        };

        Install = if cfg.autoStart then { WantedBy = [ "graphical-session.target" ]; } else {};
      };
    };
  };
}
