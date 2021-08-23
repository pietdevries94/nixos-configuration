{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.printing3d;
in {
  options.custom.setups.printing3d = {
    enable = mkEnableOption "3D printing software";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = with pkgs; [
        cura
        prusa-slicer
        meshlab
        blender
        freecad
      ];
    };
  };
}
