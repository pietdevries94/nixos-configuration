# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  graphicalConfig = {
    theme = import ../../deprecated-themes/horizon-light{
      inherit pkgs;
    };
  };
in {
  home-manager.users.piet = {
    imports = [
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];
  };
}
