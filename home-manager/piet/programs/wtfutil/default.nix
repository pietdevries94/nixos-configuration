{ config, pkgs, lib, ... }:

{
  home.packages = [pkgs.wtfutil-bin];

  xsession.windowManager.bspwm.rules = {
    "wtfutilterm" = {
      sticky = true;
      state = "fullscreen";
      center = true;
    };
  };

  services.picom.opacityRule = [ "85:class_i ?= 'wtfutilterm'" ] ;

  services.sxhkd.keybindings = {
    "mod3 + d" = "${./toggle.sh}";
  };
}