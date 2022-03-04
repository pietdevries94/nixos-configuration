{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.gaming;
in {
  options.custom.setups.gaming = {
    enable = mkEnableOption "Programs used for gaming";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

    home-manager.users.piet = {
      home.packages = with pkgs; [
        discord
        betterdiscordctl
        lutris
      ];
    };
  };
}
