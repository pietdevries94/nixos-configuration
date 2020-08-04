{ config, pkgs, options, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../overlays/unstable.nix)
      (import ../overlays/personal.nix)
      (import ../overlays/wietsedv.nix)
    ];
  };

  system.stateVersion = "20.03";
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    htop
    killall
    cachix
    lm_sensors
  ];

  # This binary cache is for my personal repository https://github.com/pietdevries94/personal-nix-channel
  nix = {
    binaryCaches = [ "https://pietdevries94.cachix.org" ];
    binaryCachePublicKeys = [ "pietdevries94.cachix.org-1:EmL0bay0YH7tI9SU3sLeyhBR5QYx+Zg6vMvBOmZ6MMQ=" ];
  };

  boot.cleanTmpDir = true;
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Amsterdam";

  programs.zsh.enable = true;
  users.users.piet = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
