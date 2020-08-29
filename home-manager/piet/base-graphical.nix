{ theme }:
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
    ./xsession/sxhkd.nix

    ./xsession/i3.nix
    (import ./xsession/polybar.nix { colors = theme.colors; })
    ./xsession/picom.nix
    ./xsession/rofi.nix
    (import ./xsession/tint2.nix { colors = theme.colors; })

    (import ./programs/vscode.nix theme.vscode)
    (import ./programs/kitty.nix { colors = theme.colors; })
  ];

  xsession.windowManager.i3.config.startup = [
    { command = "systemctl --user restart polybar"; always = true; notification = false; }
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

  services.dunst.enable = true;

  gtk = {
    enable = true;
  } // theme.gtk;

  home.packages = with pkgs; [ 
    firefox-bin
    spotify
    gimp
    remmina
    neofetch

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    gnome3.file-roller
  ];
}
