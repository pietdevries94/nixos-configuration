{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.picom;
in {
  options.custom.user.xsession.picom = {
    enable = mkEnableOption "Picom compositor for xsession";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      services.picom = {
        enable = true;
        package = pkgs.picom.overrideAttrs (oldAttrs: rec {
          # created with nix-prefetch-github --nix --rev fix-shadow-clean s0nny7 picom
          src = pkgs.fetchFromGitHub {
            owner = "s0nny7";
            repo = "picom";
            rev = "d74c099083487783af7254cb55780ffb20100e53";
            sha256 = "F4yhKHbkqtZeo94Yhac3BhX9ZpSXe1TjKZeWkfwQlFI=";
            fetchSubmodules = true;
          };
        });
        vSync = true;
        experimentalBackends = true;

        inactiveOpacity = "0.85";
        
        fade = true;
        fadeDelta = 2;
        fadeExclude =  [ "class_g = 'firefox' && window_type = 'utility'" ];
        shadow = true;
        shadowExclude = [
          "bounding_shaped && !rounded_corners"
        ];

        extraOptions = ''
          blur-method = "dual_kawase";
          blur-strength = 10;
          blur-background-exclude = [
            "window_type = 'dock'",
            "window_type = 'desktop'",
            "_GTK_FRAME_EXTENTS@:c",
          ];
          corner-radius = 10;
          round-borders = 10;
          rounded-corners-exclude = [
            "window_type = 'dock'",
            "window_type = 'desktop'",
            "_GTK_FRAME_EXTENTS@:c",
          ];
          xinerama-shadow-crop = true;
        '';
      };
    };
  };
}