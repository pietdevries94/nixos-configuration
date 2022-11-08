{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.fonts;
in {
  options.custom.setups.fonts = {
    enable = mkEnableOption "Frequently used fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      fontconfig.allowBitmaps = true;
      enableDefaultFonts = true;
      fonts = with pkgs; [
        cantarell-fonts
        corefonts
        curie
        font-awesome
        inconsolata-nerdfont
        siji
        open-sans
      ];
    };
  };
}
