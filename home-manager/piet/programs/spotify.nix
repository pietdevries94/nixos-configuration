{ config, pkgs, lib, ... }:

{
  home.packages = [
    (pkgs.callPackage (import (fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz)) {
      inherit pkgs;
      theme = "Dribbblish";
      colorScheme = "horizon";
    })
  ];
}