{ config, pkgs, ... }:

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
    extraModprobeConfig = ''
      options vfio-pci ids=10de:25a2
      options kvm_amd nested=1
    '';

    # needed for my touchbad // TODO: remove in 22.11
    # kernelPatches = pkgs.lib.singleton {
    #   name = "enable-pinctl-amd";
    #   patch = null;
    #   extraConfig = ''
    #     PINCTRL_AMD y
    #   '';
    # }; 

    
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
    themes.serendipity-morning.enable = true;

    setups.work.enable = true;
    setups.gaming.enable = true;

    user.services = {
      mailhog.enable = true;
    };

    user.programs = {
      virtualbox.enable = true;
      vscode.languages = {
        golang = true;
        vue = true;
        web = true;
        svelte = true;
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
      input.enable = true;
    };

    user.xsession.tint2 = {
      winVM = true;
      macVM = true;
    };
  };

  # Everything below is for virtualisation and should be moved to a module in the future

  environment.systemPackages = with pkgs; [
    virtmanager
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
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

  networking.hosts = {
    "192.168.122.186" = [ "macOS" ];
    "192.168.122.161" = [ "win10" ];
  };

  # services.dnsmasq = {
  #   enable = true;
  #   extraConfig = ''
  #   address=/.compenda-app.local/192.168.122.42
  #   '';
  #   servers = [
  #     "172.22.0.201"
  #     "172.22.0.202"
  #     "8.8.8.8"
  #     "8.8.4.4"
  #   ];
  # };
  # networking.networkmanager.dns = "dnsmasq";

  services.xserver.libinput.enable = true;

  systemd.services.libvirt-macOS-clean-shutdown = {
    after = [ "libvirt-guests.service" ];
    requires = [ "libvirt-guests.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = 
      let stopScript = pkgs.writeScript "stopScript" ''#!${pkgs.bash}/bin/bash
          function chkwin {
              ${pkgs.libvirt}/bin/virsh domstate --domain macOS | grep 'running' > /dev/null
          }

          if chkwin
          then
            ${pkgs.sshpass}/bin/sshpass -p systemd ${pkgs.openssh}/bin/ssh shutdown@192.168.122.186 "sudo shutdown -h now" || true
          fi
          ''; 
      in "${stopScript}";
    };
  };
}
