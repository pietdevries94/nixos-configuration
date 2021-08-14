{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.services.xserver;
in {
  options.custom.services.xserver = {
    enable = mkEnableOption "XServer";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          autoLogin.relogin = true;
        };
        autoLogin = {
          enable = true;
          user = "piet";
        };
        defaultSession = "hm-xsession";
        session = [
          {
            manage = "desktop";
            name = "hm-xsession";
            start = ''
              ${pkgs.runtimeShell} $HOME/.hm-xsession &
              waitPID=$!
            '';
          }
        ];
      };
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };
    services.gnome.glib-networking.enable = true;
    programs.nm-applet.enable = true;
  };
}
