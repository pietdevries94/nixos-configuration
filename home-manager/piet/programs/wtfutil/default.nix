{ config, pkgs, lib, ... }:

let
  settings = {
    wtf = {
      colors = {
        border = {
          focusable = "darkslateblue";
          focused = "orange";
          normal = "gray";
        };
      };
      grid = {
        columns = [38 38 38];
        rows = [12 4 10 4 4];
      };
      refreshInterval = 1;
      mods = {
        resourceusage = {
          cpuCombined = false;
          enabled = true;
          position = {
            top = 0;
            left = 0;
            height = 2;
            width = 1;
          };
          refreshInterval = 1;
          showCPU = true;
          showMem = true;
          showSwp = true;
        };
        cmdrunner_df = {
          args = ["-h"];
          cmd = "df";
          enabled = true;
          position = {
            top = 0;
            left = 1;
            height = 1;
            width = 2;
          };
          refreshInterval = 30;
          type = "cmdrunner";
        };
        cmdrunner_uptime = {
          cmd = "uptime";
          enabled = true;
          type = "cmdrunner";
          position = {
            top = 1;
            left = 1;
            height = 1;
            width = 2;
          };
          refreshInterval = 30;
        };
      };
    };
  };

  yamlFormat = pkgs.formats.yaml { };
in
{
  home.packages = [pkgs.wtfutil-bin];

  xsession.windowManager.bspwm.rules = {
    "wtfutilterm" = {
      sticky = true;
      state = "fullscreen";
      center = true;
    };
  };

  services.picom.opacityRule = [ "85:class_i ?= 'wtfutilterm'" ] ;

  services.sxhkd.keybindings = {
    "mod3 + d" = "${./toggle.sh}";
  };

  xdg.configFile."wtf/config.yml".source = yamlFormat.generate "config.yml" settings;
}