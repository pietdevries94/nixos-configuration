{ ... }:

{
  imports = [ 
    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

    ../../templates/graphical.nix
  ];
}
