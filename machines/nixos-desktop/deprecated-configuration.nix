{ config, pkgs, ... }:

let 
  graphicalConfig = {
    theme = import ../../deprecated-themes/horizon-light { inherit pkgs; };
  };
in {
  imports =
    [
      # Load non-public settings
      ../../secrets

      ../../services/xserver.nix
      ../../services/fonts.nix
    ];

  
  
  home-manager.users.piet = {
    imports = [
      ../../home-manager/piet/base.nix
      (import ../../home-manager/piet/base-graphical.nix graphicalConfig)
    ];
  };

  environment.systemPackages = [ pkgs.radeontop ];

  home-manager.users.piet.programs.git.signing.key = "81A9A2B8CB8BA05E";
}
