# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  graphicalConfig = {
    theme = import ../../themes/horizon-dark {
      inherit pkgs;
      wallpaper = ../../themes/horizon-dark/Triple-Tree-Josh-Pierce.png;
    };
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./autorandr-profiles.nix

      # Load non-public settings
      ../../secrets

      ../base.nix
      ../../services/xserver.nix
      ../../services/pulseaudio.nix
      ../../services/bluetooth.nix
      ../../services/dconf.nix
      ../../services/fonts.nix
      ../../services/32bit-support.nix
      ../../services/virtualbox.nix

      ../../services/containers
      ../../services/containers/mssql-2017.nix
      ../../services/containers/mssql-2019.nix

      ../../home-manager/base.nix
    ];

  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
      (import ../../home-manager/piet/base-work.nix graphicalConfig)
    ];
  };

  networking.useDHCP = false;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [
    # Port for barrier
    24800
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    facetimehd.enable = true;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        useOSProber = true;
        gfxmodeEfi = "1920x1080";
      };
    };
    initrd = {
      luks.devices = {
        root = {
          device = "/dev/disk/by-uuid/607667ad-06be-497e-9063-20790b6067a5";
          preLVM = true;
        };
      };
      availableKernelModules = [ "cryptd" ];
    };
  };

  # laptop specific settings
  services.xserver.libinput.enable = true;
  programs.light.enable = true;
  home-manager.users.piet.services.sxhkd.keybindings = {
    "XF86MonBrightness{Down,Up}" = "light {-U,-A} 5";
  };

  # work specific settings
  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };
  home-manager.users.piet.programs.git = {
    userEmail = "piet@compenda.nl";
    signing.key = "EEB06101168F6A0F";
  };
  programs.adb.enable = true;
  users.users.piet.extraGroups = ["adbusers"];
}
