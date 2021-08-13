{ lib, ... }:

{
  imports = [ 
    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

    ../../templates/graphical.nix
  ];

  custom = {
    themes.horizon-light.enable = true;

    setups = {
      printing3d.enable = true;
      gaming.enable = true;
    };

    user.programs = {
      vscode.languages = {
        golang = true;
        rust = true;
        vue = true;
        svelte = true;
        web = true;
      };
    };

    user.xsession.screen-locker.enable = lib.mkForce false;

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
    };
  };
}
