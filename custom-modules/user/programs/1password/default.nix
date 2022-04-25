{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs._1password;
in {
  options.custom.user.programs._1password = {
    enable = mkEnableOption "1Password";
  };

  config = mkIf cfg.enable {
    custom.impermanence.userDirectories = [
      { directory = ".config/1Password"; mode = "0700"; user = "piet"; }
    ];

    home-manager.users.piet = {
      home.packages = [pkgs._1password-gui];
      xsession.initExtra = ''
        1password --silent &
      '';
    };
  };
}
