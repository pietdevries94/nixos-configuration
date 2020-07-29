{ config, pkgs, options, ... }:

let
  unstableOverlay = import ../overlays/unstable.nix;
  personalOverlay = import ../overlays/personal.nix;
in {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ unstableOverlay personalOverlay ];
  };

  system.stateVersion = "20.03";
  system.autoUpgrade.enable = true;

  environment.systemPackages = [ pkgs.htop pkgs.killall pkgs.cachix ];

  # This binary cache is for my personal repository https://github.com/pietdevries94/personal-nix-channel
  nix = {
    binaryCaches = [ "https://pietdevries94.cachix.org" ];
    binaryCachePublicKeys = [ "pietdevries94.cachix.org-1:EmL0bay0YH7tI9SU3sLeyhBR5QYx+Zg6vMvBOmZ6MMQ=" ];
  };

  # Enable cron service and setup channel updates
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@hourly root nix-channel --update"
    ];
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
