{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.impermanence;
  check-persist = (import ./check-persist.nix) {inherit pkgs;};
in {
  options.custom.impermanence = {
    enable = mkEnableOption "Impermanence";
    directories = mkOption {
      type = types.listOf types.anything;
      default = [];
    };
    files = mkOption {
      type = types.listOf types.anything;
      default = [];
    };
    userDirectories = mkOption {
      type = types.listOf types.anything;
      default = [];
    };
    userFiles = mkOption {
      type = types.listOf types.anything;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
      ] ++ cfg.directories;
      files = [
        "/etc/machine-id"
        { file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ] ++ cfg.files;
      users.piet = {
        directories = [
          { directory = "Downloads"; user = "piet"; }
          { directory = "Pictures"; user = "piet"; }
          { directory = "Documents"; user = "piet"; }
          { directory = "Projects"; user = "piet"; }
          { directory = ".gnupg"; mode = "0700"; user = "piet"; }
          { directory = ".local/share/keyrings"; mode = "0700"; user = "piet"; }
        ] ++ cfg.userDirectories;
        files = [] ++ cfg.userFiles;
      };
    };

    security.sudo.extraConfig = ''
      %wheel      ALL=(ALL:ALL) NOPASSWD: ${check-persist}/bin/check-persist
    '';

    home-manager.users.piet = {
      home.packages = [ check-persist ];

      xsession.initExtra = ''
        sudo check-persist &
      '';
    };
  };
}
