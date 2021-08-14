{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.git;
in {
  options.custom.user.programs.git = {
    enable = mkEnableOption "git";
    userEmail = mkOption {
      type = types.str;
      default = "piet@compenda.nl";
    };
    signingKey = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.git = {
        enable = true;
        userName = "Piet de Vries";
        userEmail = cfg.userEmail;
        extraConfig= {
          pull.rebase = true;
        };

        signing = {
          signByDefault = true;
          key = cfg.signingKey;
        };
      };
    };
  };
}
