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
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];
  };

  networking.firewall.allowedTCPPorts = [
    # Port for barrier
    24800

    # Webdev stuff
    8080
    18081
    18881
  ];

  services.logind.extraConfig = "RuntimeDirectorySize = 40%";

  # work specific settings
  home-manager.users.piet.programs.git = {
    userEmail = "piet@compenda.nl";
    signing.key = "EEB06101168F6A0F";
  };
  programs.adb.enable = true;
  users.users.piet.extraGroups = ["adbusers"];
}
