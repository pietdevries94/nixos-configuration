{ config, pkgs, ... }:

{
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  users.extraUsers.piet.extraGroups = [ "audio" ];
  nixpkgs.config.pulseaudio = true;
}
