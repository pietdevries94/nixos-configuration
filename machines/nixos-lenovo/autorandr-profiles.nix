{ pkgs, ... }:

let
  eDP = "00ffffffffffff000e6f011600000000001e0104a522167803ee95a3544c99260f505400000001010101010101010101010101010101ffd700a0a0405e603020360059d710000018000000fd003078cbcb37010a202020202020000000fe0043534f542054330a2020202020000000fe004d4e473030374441312d320a200042";
  hdmiLuuk = "00ffffffffffff0006102fa00000000004190104a5211578026fb1a7554c9e250c505400000001010101010101010101010101010101ef8340a0b0083470302036004bcf1000001a000000fc00436f6c6f72204c43440a20202000000010000000000000000000000000000000000010000000000000000000000000000000cf";

  autorandr = {
    enable = true;
    profiles = {
      "work-monitor" = {
        fingerprint = {
          "eDP" = eDP;
          "HDMI-A-0" = hdmiLuuk;
        };
        config = {
          "eDP" = {
            enable = true;
            mode = "2560x1600";
            position = "0x0";
            rate = "120.01";
          };
          "HDMI-A-0" = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "work-monitor-closed" = {
        fingerprint = {
          "HDMI-A-0" = hdmiLuuk;
        };
        config = {
          "eDP".enable = false;
          "HDMI-A-0" = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "stand-alone" = {
        fingerprint = {
          "eDP" = eDP;
        };
        config = {
          "eDP" = {
            enable = true;
            primary = true;
            mode = "2560x1600";
            position = "0x0";
            rate = "120.01";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "fix-background" = "${pkgs.feh}/bin/feh --bg-fill /home/piet/.background-image.png";
      };
    };
  };
in
{
  home-manager.users.piet = {
    xsession.profileExtra = ''
      autorandr --change
    '';
    programs.autorandr = autorandr;
  };

  services.autorandr = {
    enable = true;
    defaultTarget = "common";
  };
  home-manager.users.root.programs.autorandr = autorandr;
}