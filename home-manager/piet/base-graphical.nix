{ config, pkgs, lib, ... }:

let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    clear lock
    clear mod3
    clear mod4
    keycode 66 = Hyper_L
    add mod3 = Hyper_L
    add mod4 = Super_L Super_R
  '';
in
{
  imports = [ 
    ./xsession/i3.nix
    ./xsession/polybar.nix
    ./xsession/picom.nix
    ./xsession/rofi.nix
    ./xsession/gtk.nix

    ./programs/vscode.nix
  ];

  xsession.windowManager.i3.config.startup = [
    { command = "systemctl --user restart polybar"; always = true; notification = false; }
    { command = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout} &"; always = true; notification = false; }
  ];

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };

  programs = {
    kitty = {
      enable = true;
      settings = {
        font_family = "Inconsolata Nerd Font";
        font_size = "10.0";
        window_padding_width = 4;
        foreground = "#000000";
        background = "#ffffff";
        enable_audio_bell = "no";
      };
    };
  };

  home.packages = with pkgs; [ 
    firefox-bin 
    spotify 
    gimp 
    remmina

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
  ];
}
