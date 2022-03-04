{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.rofi;
in {
  options.custom.user.xsession.rofi = {
    enable = mkEnableOption "Rofi for xsession";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.rofi = {
        enable = true;
        theme = "Arc-Dark";
      };

      services.sxhkd.keybindings = {
        "mod1 + space" = "${pkgs.rofi}/bin/rofi -show drun -modi drun -display-drun \"Search\" -show-icons";
        "mod1 + Tab" = "${pkgs.rofi}/bin/rofi -show window -modi window -display-window \"Window\" -me-accept-entry \"MousePrimary\" -me-select-entry \"MouseDPrimary\" -show-icons";
      };
    };
  };
}