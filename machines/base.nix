{ config, pkgs, options, lib, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../overlays/unstable.nix)
      (import ../overlays/personal.nix)
      (import ../overlays/wietsedv.nix)
      (import ../overlays/extra-vscode-extensions.nix)
      (import ../overlays/pull-requests.nix)
    ];
  };

  system.stateVersion = "21.05";
  system.autoUpgrade.enable = true;

  # needed for ddcutil
  boot.kernelModules = [ "i2c-dev" ];

  environment.systemPackages = with pkgs; [
    htop
    killall
    cachix
    lm_sensors
    ddcutil
  ];

  # This binary cache is for my personal repository https://github.com/pietdevries94/personal-nix-channel
  nix = {
    binaryCaches = [ "https://pietdevries94.cachix.org" ];
    binaryCachePublicKeys = [ "pietdevries94.cachix.org-1:EmL0bay0YH7tI9SU3sLeyhBR5QYx+Zg6vMvBOmZ6MMQ=" ];

    # Support flakes
    package = pkgs.nixFlakes;
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
    package = lib.mkForce pkgs.gnome.gvfs;
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
}
