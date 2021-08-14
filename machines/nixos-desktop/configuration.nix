{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./autorandr-profiles.nix

    # Load non-public settings
    ../../secrets

    # TODO remove this import when configuration is completely ported
    ./deprecated-configuration.nix

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

  services.xserver.videoDrivers = [ "amdgpu" ];

  custom = {
    themes.horizon-light.enable = true;

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
    };
  };
}
