{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.setups.base;
in {
  options.custom.setups.base = {
    enable = mkEnableOption "Base software";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      # Enable the keyring
      services.gnome-keyring.enable = true;

      nixpkgs.config = { allowUnfree = true; };
      xdg.configFile."nixpkgs/config.nix".source = pkgs.writeText "config.nix" ''
        { allowUnfree = true; }
      '';
      xdg.configFile."nix/nix.conf".source = pkgs.writeText "nix.conf" ''
        experimental-features = nix-command
        experimental-features = nix-command flakes
      '';

      home.packages = with pkgs; [
        chromium
        gimp-with-plugins
        remmina
        neofetch
        pciutils
        pavucontrol
        vlc
      ];
    };
  };
}
