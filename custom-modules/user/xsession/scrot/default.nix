{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.scrot;
in {
  options.custom.user.xsession.scrot = {
    enable = mkEnableOption "Scrot screenshots for xsession";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      services.sxhkd.keybindings = {
        "mod1 + shift + 3" = "${./screenshot.sh} full";
        "mod1 + shift + 4" = "${./screenshot.sh} selection";
      };
    };
  };
}