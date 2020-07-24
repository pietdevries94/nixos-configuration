{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.sddm = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "piet";
        relogin = true;
      };
    };
    displayManager.defaultSession = "hm-xsession";
    displayManager.session = [
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
}