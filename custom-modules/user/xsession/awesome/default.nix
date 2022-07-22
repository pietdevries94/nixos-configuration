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
        package = pkgs.awesome.overrideAttrs (oldAttrs: rec {
          # created with nix-prefetch-github --nix --rev fix-shadow-clean s0nny7 picom
          src = pkgs.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            rev = "c539e0e4350a42f813952fc28dd8490f42d934b3";
            sha256 = "EDAL7NnLF2BiVI8DAlEciiZtDmwXOzCPypGTrlN/OoQ=";
            fetchSubmodules = true;
          };
        });
      };

      home.file.".config/awesome/" = {
        source = ./conf;
        recursive = true;
      };

      home.file.".config/awesome/modules/bling" = {
        source = (fetchTarball https://github.com/BlingCorp/bling/archive/master.tar.gz);
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

local features = {}
features.laptopBrightness = true

local variables = {}
variables.colors = colors
variables.features = features

return variables
      '';
    };
  };
}