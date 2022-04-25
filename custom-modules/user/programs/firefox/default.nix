{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.firefox;

  mimeTypes = {
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";
  };

  firefoxAddonsTarball = fetchTarball https://gitlab.com/rycee/nur-expressions/-/archive/master/nur-expressions-master.tar.gz?path=pkgs/firefox-addons;
  firefoxAddons = (pkgs.callPackage "${firefoxAddonsTarball}/pkgs/firefox-addons/default.nix") {};
in {
  options.custom.user.programs.firefox = {
    enable = mkEnableOption "Firefox";
    defaultBrowser = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.firefox = {
        enable = true;
        profiles.piet = {
          settings = {
            "browser.startup.couldRestoreSession.count" = "2";
            "browser.startup.homepage_override.mstone" = pkgs.firefox.version;
            "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = "2";
            "datareporting.policy.dataSubmissionPolicyNotifiedTime" = "1649689012321";
          };
        };
        extensions = with firefoxAddons; [
          https-everywhere
          onepassword-password-manager
        ];
      };

      xdg.mimeApps = mkIf cfg.defaultBrowser {
        defaultApplications = mimeTypes;
        associations.added = mimeTypes;
      };
    };
    custom.impermanence.userFiles = [
      { file = ".mozilla/firefox/piet/extensions.json"; parentDirectory = {mode = "0700"; user = "piet"; }; }
      { file = ".mozilla/firefox/piet/extension-preferences.json"; parentDirectory = {mode = "0700"; user = "piet"; }; }
    ];
  };
}
