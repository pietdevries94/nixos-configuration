{ ... }:

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
    facetimehd.enable = true;
  };

  networking.useDHCP = false;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.networkmanager.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

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
      availableKernelModules = [ "cryptd" ]; # "aes_x86_64"
    };
  };

  custom = {
    themes.horizon-light.enable = true;

    setups.work.enable = true;

    user.services = {
      mailhog.enable = true;
    };

    user.programs = {
      virtualbox.enable = true;
      vscode.languages = {
        golang = true;
        vue = true;
        web = true;
      };
      git = {
        userEmail = "piet@compenda.nl";
        signingKey = "EEB06101168F6A0F";
      };
    };

    containers = {
      mssql-2017.enable = true;
      mssql-2019.enable = true;
    };

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
      screen.enable = true;
    };
  };
}
