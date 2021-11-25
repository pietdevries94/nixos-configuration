{ lib, ... }:

{
  # TODO remove this import when configuration is completely ported
  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base-graphical.nix
    ];
  };
  #################################################################

  imports = [
    ./hardware-configuration.nix
    ./autorandr-profiles.nix

    # Load non-public settings
    ../../secrets

    ../../templates/graphical.nix
  ];

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
        gfxmodeEfi = "2560x1440";
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

  services.xserver.videoDrivers = [ "amdgpu" ];

  custom = {
    themes.horizon-dark.enable = true;

    setups = {
      printing3d.enable = true;
      gaming.enable = true;
    };

    user.programs = {
      vscode.languages = {
        golang = true;
        rust = true;
        vue = true;
        svelte = true;
        web = true;
      };

      git.signingKey = "81A9A2B8CB8BA05E";
    };

    user.xsession.screen-locker.enable = lib.mkForce false;

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
      input.enable = true;
    };
  };

  home-manager.users.piet.xsession.windowManager.bspwm.monitors = lib.mkForce {
    HDMI-A-0 = [ "1" "2" "3" "4" "5" "6" "7" ];
    DisplayPort-0 = [ "8" "9" "0" ];
  };
}
