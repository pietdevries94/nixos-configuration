{ config, pkgs, lib, ... }:

{
  services.picom = {
    enable = true;
    vSync = true;
    experimentalBackends = true;

    inactiveOpacity = "0.85";
    
    fade = true;
    fadeDelta = 2;
    fadeExclude =  [ "class_g = 'firefox' && window_type = 'utility'" ];
    shadow = true;

    extraOptions = ''
      blur-method = "gaussian";
      blur-size = 20;
      blur-deviation = 15.0;
      blur-background-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'",
        "_GTK_FRAME_EXTENTS@:c",
      ];
    '';
  };
}
