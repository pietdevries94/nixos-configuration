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
    enableAllFirmware = true;
  };

  boot = {
    # initrd = {
    #   availableKernelModules = [ "amdgpu" "vfio-pci" ];
    #   preDeviceCommands = ''
    #     DEVS="0000:01:00.0"
    #     for DEV in $DEVS; do
    #       echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #     done
    #     modprobe -i vfio-pci
    #   '';
    # };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.backlight=0" "acpi_backlight=none" "amd_iommu=on" "pcie_aspm=off" ];
    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    extraModprobeConfig = "options vfio-pci ids=10de:25a2";
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

  networking.networkmanager.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.logind.lidSwitch = "hibernate";

  custom = {
    themes.horizon-light.enable = true;

    setups.work.enable = true;
    setups.gaming.enable = true;

    user.services = {
      mailhog.enable = true;
    };

    user.programs = {
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
      mssql-2019 = {
        enable = true;
        autoStart = true;
      };
    };

    hardware = {
      bluetooth.enable = true;
      audio.enable = true;
      screen.enable = true;
      moonlander.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    virtmanager
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    onBoot = "ignore";
    # suspending is not an option with pci passtrough
    onShutdown = "shutdown";
  };

  users.users.piet.extraGroups = [ "libvirtd" ];

  services.samba = {
    enable = true;
    securityType = "user";
    shares = {
      home = {
        path = "/home/piet";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0640";
        "directory mask" = "0750";
      };
    };
  };
  
  networking.firewall.interfaces.virbr0 = {
    allowedTCPPorts = [ 445 139 ];
    allowedUDPPorts = [ 137 138 ];
  };

  security.sudo.extraConfig = ''
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh domstate --domain win10
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh start win10
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh shutdown win10
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh domstate --domain macOS
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh start macOS
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.libvirt}/bin/virsh shutdown macOS
  '';
}
