{ config, pkgs, ... }:

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

    # Load non-public settings
    ../../secrets

    ../../templates/graphical.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    firmware = [ pkgs.rtw89-firmware ];
  };

  boot = {
    kernelParams = [ "amdgpu.backlight=0" "acpi_backlight=none" ];
    extraModulePackages = [ config.boot.kernelPackages.rtw89 ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  networking.hostName = "nixos-lenovo"; # Define your hostname.
  networking.networkmanager.enable = true;

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

