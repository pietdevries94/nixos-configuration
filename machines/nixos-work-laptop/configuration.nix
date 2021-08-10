{ ... }:

{
  imports = [ 
    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

    ../../templates/graphical.nix
  ];

  custom.user.services = {
    mailhog.enable = true;
  };

  custom.containers = {
    mssql-2017.enable = true;
    mssql-2019.enable = true;
  }

  custom.hardware = {
    bluetooth.enable = true;
    audio.enable = true;
  };
}
