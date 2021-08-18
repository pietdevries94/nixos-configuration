{ config, pkgs, lib, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom.overrideAttrs (oldAttrs: rec {
      # created with nix-prefetch-github --nix --rev next yshui picom
      src = pkgs.fetchFromGitHub {
        owner = "yshui";
        repo = "picom";
        rev = "78e8666498490ae25349a44f156d0811b30abb70";
        sha256 = "k39uebbqSUOxke2BjaIxgccJNz+mhlhAtTtmxhIHo1M=";
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

    extraOptions = ''
      blur-method = "dual_kawase";
      blur-strength = 10;
      blur-background-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'",
        "_GTK_FRAME_EXTENTS@:c",
      ];
    '';
  };
}
