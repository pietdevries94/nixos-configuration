{ ... }:

{
  imports = [ ./minimal.nix ];

  programs.dconf.enable = true;

  custom = {
    user.programs = {
      alacritty.enable = true;
      vscode.enable = true;
    };

    user.xsession.screen-locker.enable = true;
  };
}