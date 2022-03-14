{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.awesome;
  ui = cfg.colors.ui;
in {
  options.custom.user.xsession.awesome = {
    enable = mkEnableOption "Window manager for xsession";
    colors = mkOption {
      type = types.anything;
    };
  };

  config = mkIf cfg.enable {
    # custom.user.xsession.picom.cornerRadius = "0";
    home-manager.users.piet = {
      xsession.windowManager.awesome = {
        enable = true;
      };

      home.file.".config/awesome/variables.lua".text = ''
local colors = {}
colors.accent = "${ui.accent}"
colors.accentAlt = "${ui.accentAlt}"
colors.secondaryAccent = "${ui.secondaryAccent}"
colors.secondaryAccentAlt = "${ui.secondaryAccentAlt}"
colors.tertiaryAccent = "${ui.tertiaryAccent}"
colors.background = "${ui.background}"
colors.backgroundAlt = "${ui.backgroundAlt}"
colors.foreground = "${ui.foreground}"
colors.foregroundAlt = "${ui.foregroundAlt}"

local variables = {}
variables.colors = colors

return variables
      '';
    };
  };
}