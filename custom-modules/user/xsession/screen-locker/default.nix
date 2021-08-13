{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.screen-locker;
in {
  options.custom.user.xsession.screen-locker = {
    enable = mkEnableOption "Screen locker for xsession";
    colors = mkOption {
      type = types.anything;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = [ pkgs.xautolock ];
      xsession.initExtra = ''
        ${pkgs.caffeine-ng}/bin/caffeine &
      '';
      
      services.screen-locker = {
        enable = true;
        inactiveInterval = 1;
        lockCmd = ''
          ${pkgs.i3lock-color}/bin/i3lock-color \
          -c ${cfg.colors.ui.background} \
          \
          --linecolor=${cfg.colors.ui.background}FF \
          --insidevercolor=${cfg.colors.ui.background}FF \
          --insidewrongcolor=${cfg.colors.ui.background}FF \
          --insidecolor=${cfg.colors.ui.background}FF \
          \
          --ringcolor=${cfg.colors.ui.foreground}FF \
          --keyhlcolor=${cfg.colors.ui.tertiaryAccent}FF \
          --bshlcolor=${cfg.colors.ui.tertiaryAccent}FF \
          --separatorcolor=${cfg.colors.ui.tertiaryAccent}FF \
          \
          --ringvercolor=${cfg.colors.ui.secondaryAccent}FF \
          --ringwrongcolor=${cfg.colors.ui.negative}FF \
          \
          --veriftext="" \
          --wrongtext="" \
          --noinputtext="" \
          --locktext="" \
          --lockfailedtext="" \
          -n
        '';
      };
    };
  };
}
