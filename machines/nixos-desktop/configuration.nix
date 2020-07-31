{ config, pkgs, ... }:

let 
  graphicalConfig = {
    theme = import ../../themes/horizon { pkgs = pkgs; };
  };
in {
  imports =
    [
      ./hardware-configuration.nix
      ../base.nix

      ../../services/xserver.nix
      ../../services/pulseaudio.nix
      ../../services/bluetooth.nix
      ../../services/dconf.nix
      ../../services/fonts.nix

      ../../home-manager/base.nix
    ];
  
  home-manager.users.piet = {
    imports = [
      ./autorandr-profiles.nix

      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];


    services.polybar.script = ''
      MONITOR=HDMI-A-0 polybar top &
      MONITOR=DVI-D-0 polybar top &
    '';
  };

  services.xserver.desktopManager.wallpaper = "fill";

  environment.systemPackages = [ pkgs.radeontop ];

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
          device = "/dev/disk/by-uuid/6f71e24b-4258-44e7-8ef0-75a1ee7a762e";
          preLVM = true;
        };
      };
      availableKernelModules = [ "cryptd" ];
    };
  };

  networking = {
    hostName = "nixos-desktop";
    useDHCP = false;
    interfaces = {
      enp10s0.useDHCP = true;
      wlp9s0.useDHCP = true;
    };
    wireless = {
      enable = true;
      networks = import ../../secrets/networks.nix;
    };
  };
}
