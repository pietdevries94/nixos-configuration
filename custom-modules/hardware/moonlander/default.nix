{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.hardware.moonlander;
  foo = pkgs.writeScript "foo.sh" ''#!${pkgs.bash}/bin/bash
  echo 'cat' >> /tmp/foo
  '';
in {
  options.custom.hardware.moonlander = {
    enable = mkEnableOption "Moonlander";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
        MODE:="0666", \
        SYMLINK+="stm32_dfu"

      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", RUN+="${foo}"
    '';
    users = {
      groups.plugdev = {};
      users.piet.extraGroups = [ "plugdev" ];
    };
    home-manager.users.piet = {
      home.packages = with pkgs; [
        wally-cli
      ];
    };
  };
}
