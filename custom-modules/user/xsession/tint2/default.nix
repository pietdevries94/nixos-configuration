{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.tint2;
in {
  options.custom.user.xsession.tint2 = {
    enable = mkEnableOption "Tint2 for xsession";
    colors = mkOption {
      type = types.anything;
    };
    scriptIcons = mkOption {
      type = types.anything;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = with pkgs; [
        tint2
      ];

      home.file.".config/tint2/tint2rc".source = (import ./tint2rc.nix { colors = cfg.colors; scriptIcons = cfg.scriptIcons; inherit (pkgs) writeText; });
      home.file.".config/tint2/scripts".source = ./scripts;
      home.file.".config/tint2/executor".source = ./executor;

      xsession.initExtra = ''
        tint2 &
        blueman-applet &
      '';
    };
  };
}
