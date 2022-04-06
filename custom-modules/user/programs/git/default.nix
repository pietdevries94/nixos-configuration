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
      default = "";
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
          init.defaultBranch = "main";
        };

        signing = {
          signByDefault = (cfg.signingKey != "");
          key = cfg.signingKey;
        };
      };
    };
  };
}
