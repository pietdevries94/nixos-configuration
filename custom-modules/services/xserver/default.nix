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
      desktopManager.gnome.enable = true;
      
      enable = true;
      displayManager = {
        gdm.enable = true;
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
  };
}
