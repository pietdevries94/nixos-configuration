{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.alacritty;
in {
  options.custom.user.programs.alacritty = {
    enable = mkEnableOption "Alacritty";
    colors = mkOption {
      type = types.anything;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.alacritty = {
        enable = true;
        settings = {
          env = {
            # WINIT_X11_SCALE_FACTOR = "1.25";
            TERM = "xterm-256color";
          };
          window.padding = {
            x = 6;
            y = 3;
          };
          font = {
            size = 9.0;
          };

          colors = {
            primary = {
              foreground = cfg.colors.ui.foreground;
              background = cfg.colors.ui.background;
            };

            normal = cfg.colors.normal;
            bright = cfg.colors.bright;
          };
        };
      };

      # TODO: only enable this if sxhkd is enabled
      services.sxhkd.keybindings = {
        "mod3 + Return" = "alacritty";
        "mod1 + Return" = "alacritty";
      };
    };
  };
}
