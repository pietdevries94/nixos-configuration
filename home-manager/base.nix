{ config, pkgs, ... }:

let
  hmTarball = fetchTarball https://github.com/rycee/home-manager/archive/release-20.03.tar.gz;
in {
  imports = [ (import "${hmTarball}/nixos") ];
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}