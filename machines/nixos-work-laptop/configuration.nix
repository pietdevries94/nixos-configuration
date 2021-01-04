# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  graphicalConfig = {
    theme = import ../../themes/horizon-dark { inherit pkgs; };
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../base.nix
      ../../services/xserver.nix
      ../../services/pulseaudio.nix
      ../../services/bluetooth.nix
      ../../services/dconf.nix
      ../../services/fonts.nix
      ../../services/32bit-support.nix
      ../../services/virtualbox.nix

      ../../home-manager/base.nix
    ];

  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
      ../../home-manager/piet/base-work.nix
    ];
  };

  networking.useDHCP = false;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.networkmanager.enable = true;

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
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
}