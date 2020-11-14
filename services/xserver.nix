{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
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
  services.gnome3.glib-networking.enable = true;
}