{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "20.03";
  system.autoUpgrade.enable = true;

  boot.cleanTmpDir = true;

  programs.zsh.enable = true;
  users.users.piet = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = [ pkgs.htop pkgs.killall ];
}
