{ pkgs, ... }:

let
  hmTarball = fetchTarball https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz;
  impermanenceTarball = fetchTarball https://github.com/nix-community/impermanence/archive/refs/heads/master.tar.gz;
in {
  imports = [ 
    ../custom-modules
    (import "${hmTarball}/nixos")
    (import "${impermanenceTarball}/nixos.nix")
  ];

    nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../overlays/personal.nix)
      (import ../overlays/unstable.nix)
      (import ../overlays/wietsedv.nix)
      (import ../overlays/extra-vscode-extensions.nix)
      (import ../overlays/pull-requests.nix)
    ];
  };

  system.stateVersion = "21.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # needed for ddcutil
  boot.kernelModules = [ "i2c-dev" ];

  environment.systemPackages = with pkgs; [
    htop
    killall
    lm_sensors
    ddcutil
  ];

  # This binary cache is for my personal repository https://github.com/pietdevries94/personal-nix-channel
  nix = {
    binaryCaches = [ "https://pietdevries94.cachix.org" ];
    binaryCachePublicKeys = [ "pietdevries94.cachix.org-1:EmL0bay0YH7tI9SU3sLeyhBR5QYx+Zg6vMvBOmZ6MMQ=" ];

    # Support flakes
    package = pkgs.nix_2_4;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.cleanTmpDir = true;
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Amsterdam";
  networking.networkmanager.enable = true;

  programs = {
    zsh.enable = true;
  };

  services.gvfs = {
    enable = true;
  };

  users.users.piet = {
    # Password made with mkpasswd -m sha-512
    hashedPassword = import ../secrets/password-piet.nix;

    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "input" ];
  };

  security.sudo.enable = true;
  security.sudo.extraConfig = ''
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/poweroff
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/reboot
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl suspend
    %wheel      ALL=(ALL:ALL) NOPASSWD: ${pkgs.ddcutil}/bin/ddcutil
  '';

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  virtualisation.oci-containers = {
    backend = "podman";
  };

  custom.user.programs = {
    shell.enable = true;
    git.enable = true;
    gpg-agent.enable = true;
    ssh.enable = true;
  };
}