{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.bluetooth;
in {
  options.custom.hardware.bluetooth = {
    enable = mkEnableOption "Bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
