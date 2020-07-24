{ config, pkgs, ... }:

{
  imports =
    [
      ../channels/home-manager.nix
    ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}