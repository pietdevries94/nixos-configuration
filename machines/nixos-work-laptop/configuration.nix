{ ... }:

{
  imports = [ 
    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

    ../../templates/graphical.nix
  ];

  custom = {
    themes.horizon-light.enable = true;

    user.services = {
      mailhog.enable = true;
    };

    user.programs = {
      virtualbox.enable = true;
      vscode.languages = {
        golang = true;
        vue = true;
        web = true;
      };
    };

    containers = {
      mssql-2017.enable = true;
      mssql-2019.enable = true;
    };

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
    };
  };
}
