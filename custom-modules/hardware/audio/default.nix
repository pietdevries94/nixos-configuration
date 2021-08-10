{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.audio;
in {
  options.custom.hardware.audio = {
    enable = mkEnableOption "Audio";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    users.extraUsers.piet.extraGroups = [ "audio" ];
    nixpkgs.config.pulseaudio = true;
  };
}
