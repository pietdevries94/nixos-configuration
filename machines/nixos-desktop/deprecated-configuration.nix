{ config, pkgs, ... }:

let 
  graphicalConfig = {
    theme = import ../../deprecated-themes/horizon-light { inherit pkgs; };
  };
in {
  imports =
    [
      ./hardware-configuration.nix
      ./autorandr-profiles.nix
      ../deprecated-base.nix

      # Load non-public settings
      ../../secrets

      ../../services/xserver.nix
      ../../services/fonts.nix
      ../../services/32bit-support.nix

      ../../home-manager/base.nix
    ];

  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
      ../../home-manager/piet/games.nix
    ];


    services.polybar.script = ''
      MONITOR=HDMI-A-0 polybar top &
      MONITOR=DVI-D-0 polybar top &
    '';
  };

  environment.systemPackages = [ pkgs.radeontop ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    opengl.driSupport = true;
    # opengl.extraPackages = [ pkgs.amdvlk ];
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
      timeout = -1;
    };
    initrd = {
      luks.devices = {
        root = {
          device = "/dev/disk/by-uuid/6f71e24b-4258-44e7-8ef0-75a1ee7a762e";
          preLVM = true;
        };
      };
      availableKernelModules = [ "cryptd" ]; # "aes_x86_64"
    };
  };

  home-manager.users.piet.programs.git.signing.key = "81A9A2B8CB8BA05E";

  programs.steam.enable = true;
}
