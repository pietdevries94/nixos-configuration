{ lib, pkgs, ... }:

{
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
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  custom = {
    impermanence.enable = true;

    themes.serendipity-morning.enable = true;

    setups = {
      gaming.enable = true;
    };

    user.programs = {
      vscode.languages = {
        golang = true;
        vue = true;
        svelte = true;
        web = true;
      };
    };

    user.xsession = {
      screen-locker.enable = lib.mkForce false;
      bspwm.windowGap = 30;
    };

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
