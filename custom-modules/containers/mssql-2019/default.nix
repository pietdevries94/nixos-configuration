{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.containers.mssql-2019;
in {
  options.custom.containers.mssql-2019 = {
    enable = mkEnableOption "A container with MSSQL 2019";
    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, the MSSQL 2019 will start when the system starts
      '';
    };
    
  };

  config = mkIf cfg.enable {
    systemd.services.ensure-container-volumes-mssql-2019 = {
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /srv/container-volumes/mssql-2019
        chown -R 10001 /srv/container-volumes/mssql-2019
      '';
      wantedBy = [ "multi-user.target" ];
    };

    virtualisation.oci-containers.containers.mssql-2019 = {
      autoStart = cfg.autoStart;
      image = "mcr.microsoft.com/mssql/server:2019-latest";
      ports = [
        "14019:1433"
      ];
      environment = {
        ACCEPT_EULA = "Y";
        SA_PASSWORD = "yourStrong(!)Password";
      };
      volumes = [
        "/srv/container-volumes/mssql-2019:/var/opt/mssql"
      ];
    };
  };
}
