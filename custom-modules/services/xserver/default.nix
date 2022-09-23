{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.services.xserver;
in {
  options.custom.services.xserver = {
    enable = mkEnableOption "XServer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.gnomeExtensions; [
      pkgs.gnome.gnome-tweaks

      appindicator
      night-theme-switcher
      pop-shell
      caffeine
      display-ddc-brightness-volume
      bluetooth-quick-connect
    ];

    home-manager.users.piet.dconf.settings = {
      "org/gnome/Console" = {
        theme = "auto";
      };
      "org/gnome/desktop/wm/preferences" = {
        auto-raise = false;
        focus-mode = "sloppy";
      };
      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        dynamic-workspaces = true;
        edge-tiling = true;
        focus-change-on-pointer-rest = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "caffeine@patapon.info"
          "display-ddc-brightness-volume@sagrland.de"
          "nightthemeswitcher@romainvigier.fr"
          "pop-shell@system76.com"
          "bluetooth-quick-connect@bjarosze.gmail.com"
        ];
        welcome-dialog-last-shown-version = "42.4";
      };
      "org/gnome/shell/extensions/nightthemeswitcher/gtk-variants" = {
        day = "Adwaita";
        enabled = true;
        night = "Adwaita-dark";
      };
      "org/gnome/shell/extensions/nightthemeswitcher/time" = {
        always-enable-ondemand = true;
      };
      "org/gnome/shell/extensions/pop-shell" = {
        tile-by-default = true;
      };
    };
    services.xserver = {
      desktopManager.gnome = {
        enable = true;
      };

      enable = true;
      displayManager.gdm.enable = true;
      
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };
  };
}
