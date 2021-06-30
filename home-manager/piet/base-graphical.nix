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
    
    (import ./xsession/bspwm { inherit colors; })
    ./xsession/picom.nix
    (import ./xsession/rofi.nix { inherit colors; })
    (import ./xsession/tint2 { inherit colors; inherit (theme.tint2) scriptIcons; })
    (import ./xsession/dunst.nix { inherit colors; inherit (theme.gtk) iconTheme; })
    ./xsession/scrot
    ./xsession/libinput-gestures.nix
    # (import ./xsession/screen-locker.nix { inherit colors; })

    (import ./programs/vscode.nix theme.vscode)
    (import ./programs/alacritty.nix { inherit colors; })
    (import ./programs/spotify.nix theme.spotify)
    ./programs/wtfutil
  ];


  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    initExtra = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout} &
      ${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png
      
      # This is to force the one time setup
      zsh -c "source .zshrc"

      # Clean Download folder
      find /home/piet/Downloads -maxdepth 1 -mtime +14 -exec rm -rf {} \;
    '';
  };

  # Media controls
  services.sxhkd.keybindings = {
    "XF86Audio{Play,Prev,Next}" = "${pkgs.playerctl}/bin/playerctl {play-pause,previous,next}";
    # TODO: move volume script from Tint2
    "XF86Audio{LowerVolume,RaiseVolume,Mute}" = "~/.config/tint2/scripts/change-volume.sh {down,up,mute} ${theme.tint2.scriptIcons.outputVolume}";
  };

  home.file.".background-image.png".source = theme.wallpaper;

  gtk = {
    enable = true;
  } // theme.gtk;
  
  home.packages = with pkgs; [ 
    firefox-bin
    gimp
    remmina
    neofetch
    pciutils
    pavucontrol
    # TODO: enable cordium after 20.09 fix
    # cordium

    # File manager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler
    gnome.file-roller

    # Basic utils
    gnome.gnome-calculator
    gnome.eog
  ];
}
