{ ... }:

{
  imports = [ ./minimal.nix ];

  programs.dconf.enable = true;

  custom = {
    user.programs = {
      alacritty.enable = true;
      vscode.enable = true;
      spotify.enable = true;
    };

    user.services.kdeconnect.enable = true;

    user.xsession.screen-locker.enable = true;
  };
}