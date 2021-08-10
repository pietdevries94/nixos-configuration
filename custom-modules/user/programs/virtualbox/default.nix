{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.virtualbox;
in {
  options.custom.user.programs.virtualbox = {
    enable = mkEnableOption "Virtualbox";
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      
      # Enabling this triggers frequent recompiles and is only needed for passtrough, which I don't need
      # enableExtensionPack = true;
    };
    users.extraGroups.vboxusers.members = [ "piet" ];
  };
}
