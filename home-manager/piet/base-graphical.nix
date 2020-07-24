{ config, pkgs, lib, ... }:

let 
  unstable = import ../../channels/unstable.nix;
  personal = import ../../channels/personal.nix;
in
{
  imports = [ 
    ./xsession/i3.nix
    ./xsession/polybar.nix
    ./xsession/picom.nix
  ];

  xsession.windowManager.i3.config.startup = [
    { command = "systemctl --user restart polybar"; always = true; notification = false; }
  ];

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };

  programs = {
    vscode = {
      enable = true;
      package = personal.vscodium;
      extensions = [ unstable.vscode-extensions.bbenoist.Nix ];
    };
    rofi.enable = true;
  };

  home.packages = [ pkgs.firefox-bin unstable.spotify pkgs.gimp ];
}
