{ config, pkgs, ... }:

{
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
  };
  services.gnome.glib-networking.enable = true;
  programs.nm-applet.enable = true;
  services.xserver.libinput.enable = true; # I use an external trackpad
}
