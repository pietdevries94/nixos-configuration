{ ... }:

{
  imports = [ 
    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

    ../../templates/graphical.nix
  ];

  custom.user.programs = {
    setup3dprinting.enable = true;
  };

  custom.hardware = {
    bluetooth.enable = true;
    audio.enable = true;
  };
}
