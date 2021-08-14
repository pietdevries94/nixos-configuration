{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.gpg-agent;
in {
  options.custom.user.programs.gpg-agent = {
    enable = mkEnableOption "gpg-agent";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        defaultCacheTtl = 500;
        defaultCacheTtlSsh = 500;
      };
    };
  };
}
