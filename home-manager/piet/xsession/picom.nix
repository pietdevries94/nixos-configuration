{ config, pkgs, lib, ... }:

let
  unstable = import ../../../channels/unstable.nix;
in
{
  services.picom = {
    enable = true;
    package = unstable.picom;
    vSync = true;
    experimentalBackends = true;

    # inactiveOpacity = "0.85";
    
    # fade = true;
    # fadeDelta = 3;
    # fadeExclude =  [ "class_g = 'firefox' && window_type = 'utility'" ];

    # extraOptions = ''
    #   blur-method = "gaussian";
    #   blur-size = 20;
    #   blur-deviation = 15.0;
    #   blur-background-exclude = [
    #     "window_type = 'dock'",
    #     "window_type = 'desktop'",
    #     "_GTK_FRAME_EXTENTS@:c",
    #   ];
    # '';
  };
}
