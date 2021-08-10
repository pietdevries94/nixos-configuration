{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.containers.mssql-2017;
in {
  options.custom.containers.mssql-2017 = {
    enable = mkEnableOption "A container with MSSQL 2017";
    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, the MSSQL 2017 will start when the system starts
      '';
    };
    
  };

  config = mkIf cfg.enable {
    systemd.services.ensure-container-volumes-mssql-2017 = {
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /srv/container-volumes/mssql-2017
        chown 10001 /srv/container-volumes/mssql-2017
      '';
      wantedBy = [ "multi-user.target" ];
    };

    virtualisation.oci-containers.containers.mssql-2017 = {
      autoStart = cfg.autoStart;
      image = "mcr.microsoft.com/mssql/server:2017-latest";
      ports = [
        "14017:1433"
      ];
      environment = {
        ACCEPT_EULA = "Y";
        SA_PASSWORD = "yourStrong(!)Password";
      };
      volumes = [
        "/srv/container-volumes/mssql-2017:/var/opt/mssql"
      ];
    };
  };
}
