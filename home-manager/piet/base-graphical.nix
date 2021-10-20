{ config, pkgs, lib, ... }:

let
  theme = import ../../deprecated-themes/horizon-light{
    inherit pkgs;
  };

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
    (import ./xsession/dunst.nix { inherit colors; inherit (theme.gtk) iconTheme; })
    ./xsession/scrot
    ./xsession/libinput-gestures.nix
    # (import ./xsession/screen-locker.nix { inherit colors; })
  ];


  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    initExtra = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout} &
      ${pkgs.xcape}/bin/xcape -e 'Shift_L=Shift_L|9;Shift_R=Shift_L|0'

      ${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png
      
      # This is to force the one time setup
      zsh -c "source .zshrc"

      # Clean Download folder
      find /home/piet/Downloads -maxdepth 1 -mtime +14 -exec rm -rf {} \;

      mkdir -p /home/piet/Archive/week
      mkdir -p /home/piet/Archive/month
      mkdir -p /home/piet/Archive/6months
      mkdir -p /home/piet/Archive/year
      find /home/piet/Archive/week -maxdepth 1 -mtime +7 -exec rm -rf {} \;
      find /home/piet/Archive/month -maxdepth 1 -mtime +31 -exec rm -rf {} \;
      find /home/piet/Archive/6months -maxdepth 1 -mtime +183 -exec rm -rf {} \;
      find /home/piet/Archive/year -maxdepth 1 -mtime +365 -exec rm -rf {} \;
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

  # Enable the keyring
  services.gnome-keyring.enable = true;

  # Enable KDE-connect
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  
  home.packages = with pkgs; [ 
    firefox-bin
    chromium
    gimp
    remmina
    neofetch
    pciutils
    pavucontrol
    vlc
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
    gnome.seahorse
    gnome.gnome-system-monitor
  ];
}
