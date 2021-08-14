{ config, pkgs, ... }:

let 
  graphicalConfig = {
    theme = import ../../deprecated-themes/horizon-light { inherit pkgs; };
  };
in {  
  home-manager.users.piet = {
    imports = [
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];
  };

  environment.systemPackages = [ pkgs.radeontop ];
}
