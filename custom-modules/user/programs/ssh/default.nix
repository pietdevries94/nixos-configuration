{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.ssh;
in {
  options.custom.user.programs.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.ssh.enable = true;
    };
  };
}
