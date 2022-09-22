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
      vscode.enable = true;
      firefox.enable = true;
      spotify.enable = true;
      _1password.enable = true;
    };
  };
}