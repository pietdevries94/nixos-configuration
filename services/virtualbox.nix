{ config, pkgs, ... }:

{
  virtualisation.virtualbox.host = {
    enable = true;
    
    # Enabling this triggers frequent recompiles and is only needed for passtrough, which I don't need
    # enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "piet" ];
}