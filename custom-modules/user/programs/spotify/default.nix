{ lib, pkgs, config, ... }:
with lib;
let
  spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;

  cfg = config.custom.user.programs.spotify;
in {
  options.custom.user.programs.spotify = {
    enable = mkEnableOption "Spotify";
    colorScheme = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      # imports = [ (import "${spicetify}/module.nix") ];

      # programs.spicetify = {
      #   enable = true;
      #   theme = "Dribbblish";
      #   colorScheme = cfg.colorScheme;
      # };
      home.packages = with pkgs; [
        spotify
      ];
    };
  };
}