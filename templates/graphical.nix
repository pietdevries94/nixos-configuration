{ ... }:

{
  imports = [ ./minimal.nix ];

  programs.dconf.enable = true;

  custom = {
    services.xserver.enable = true;

    setups.fonts.enable = true;

    user.programs = {
      alacritty.enable = true;
      vscode.enable = true;
      spotify.enable = true;
    };

    user.services.kdeconnect.enable = true;

    user.xsession = {
      screen-locker.enable = true;
      tint2.enable = true;
    };
  };
}