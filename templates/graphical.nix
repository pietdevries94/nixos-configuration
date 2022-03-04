{ ... }:

{
  imports = [ ./minimal.nix ];

  programs.dconf.enable = true;

  custom = {
    services.xserver.enable = true;

    setups = {
      base.enable = true;
      fonts.enable = true;
    };

    user.programs = {
      alacritty.enable = true;
      vscode.enable = true;
      spotify.enable = true;
    };

    user.services.kdeconnect.enable = true;

    user.xsession = {
      base.enable = true;
      bspwm.enable = true;
      dunst.enable = true;
      picom.enable = true;
      rofi.enable = true;
      screen-locker.enable = true;
      scrot.enable = true;
      tint2.enable = true;
    };
  };
}