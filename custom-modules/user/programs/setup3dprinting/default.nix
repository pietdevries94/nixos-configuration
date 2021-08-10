{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.setup3dprinting;
in {
  options.custom.user.programs.setup3dprinting = {
    enable = mkEnableOption "3D printing software";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = with pkgs; [
        cura
        prusa-slicer
        meshlab
        blender
      ];
    };
  };
}
