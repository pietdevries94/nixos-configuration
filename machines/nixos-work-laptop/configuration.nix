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

      ../../home-manager/base.nix
    ];

  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];
  };

  networking.useDHCP = false;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.networkmanager.enable = true;

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


  services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

