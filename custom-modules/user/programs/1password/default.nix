{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs._1password;
in
{
  options.custom.user.programs._1password = {
    enable = mkEnableOption "1Password";
  };

  config = mkIf cfg.enable {
    custom.impermanence.userDirectories = [
      { directory = ".config/1Password"; mode = "0700"; user = "piet"; }
    ];

    programs._1password-gui = {
      enable = true;
      # gid = 5000;
      polkitPolicyOwners = [ "piet" ];
    };

    home-manager.users.piet = {
      xsession.initExtra = ''
        1password --silent &
      '';
    };
  };
}
