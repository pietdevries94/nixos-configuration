{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.screen;
in {
  options.custom.hardware.screen = {
    enable = mkEnableOption "screen";
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;
    home-manager.users.piet.services.sxhkd.keybindings = {
      "XF86MonBrightness{Down,Up}" = "light {-U,-A} 5";
    };
  };
}
