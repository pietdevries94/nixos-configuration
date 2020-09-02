{ theme }:
{ config, pkgs, lib, ... }:

let
  inherit (theme) colors;

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
  # Imports may provide keybindings for sxhkd
  services.sxhkd.enable = true;

  imports = [
    # (import ./xsession/polybar.nix { inherit colors; })
    # ./xsession/i3.nix
    
    (import ./xsession/bspwm.nix { inherit colors; })
    ./xsession/picom.nix
    (import ./xsession/rofi.nix { inherit colors; })
    (import ./xsession/tint2.nix { inherit colors; })
    (import ./xsession/dunst.nix { inherit colors; iconTheme = theme.gtk.iconTheme; })

    (import ./programs/vscode.nix theme.vscode)
    (import ./programs/kitty.nix { inherit colors; })
  ];


  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    initExtra = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout} &
      ${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png
    '';
  };

  home.file.".background-image.png".source = theme.wallpaper;

  gtk = {
    enable = true;
  } // theme.gtk;

  home.packages = with pkgs; [ 
    firefox-bin
    spotify
    gimp
    remmina
    neofetch
    pciutils
    steam
    discord
    pavucontrol

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler
    gnome3.file-roller
  ];
}
