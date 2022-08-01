{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.xsession.base;
in {
  options.custom.user.xsession.base = {
    enable = mkEnableOption "Base for xsession";
    gtkTheme = mkOption {
      type = types.anything;
    };
    volumeIcon = mkOption {
      type = types.str;
    };
    wallpaper = mkOption {
      type = types.path;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      xsession = {
        enable = true;
        scriptPath = ".hm-xsession";
        initExtra = ''
          ${pkgs.xcape}/bin/xcape -e 'Shift_L=Shift_L|9;Shift_R=Shift_L|0'

          ${pkgs.feh}/bin/feh --bg-fill ~/.background-image.png
          
          # This is to force the one time setup
          zsh -c "source .zshrc"

          # Clean Download folder
          find /home/piet/Downloads -maxdepth 1 -mtime +14 -exec rm -rf {} \;

          mkdir -p /home/piet/Archive/week
          mkdir -p /home/piet/Archive/month
          mkdir -p /home/piet/Archive/6months
          mkdir -p /home/piet/Archive/year
          find /home/piet/Archive/week -maxdepth 1 -mtime +7 -exec rm -rf {} \;
          find /home/piet/Archive/month -maxdepth 1 -mtime +31 -exec rm -rf {} \;
          find /home/piet/Archive/6months -maxdepth 1 -mtime +183 -exec rm -rf {} \;
          find /home/piet/Archive/year -maxdepth 1 -mtime +365 -exec rm -rf {} \;
        '';
      };

      home.file.".background-image.png".source = cfg.wallpaper;

      # Media controls
      services.sxhkd.keybindings = {
        "XF86Audio{Play,Prev,Next}" = "${pkgs.playerctl}/bin/playerctl {play-pause,previous,next}";
        # TODO: move volume script from Tint2
        "XF86Audio{LowerVolume,RaiseVolume,Mute}" = "${../tint2/scripts/change-volume.sh} {down,up,mute} ${cfg.volumeIcon}";
      };

      gtk = {
        enable = true;
      } // cfg.gtkTheme;

      # Other modules might add keybindings
      services.sxhkd.enable = true;
    };
  };
}
