{ config, pkgs, lib, ... }:

let
  unstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
  personal = import <personal> {};
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

  home.packages = [ 
    pkgs.firefox-bin 
    unstable.spotify 
    pkgs.gimp 
    pkgs.remmina

    # File manager
    pkgs.xfce.thunar
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-volman
  ];

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
