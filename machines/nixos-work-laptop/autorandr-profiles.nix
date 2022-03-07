{ pkgs, ... }:

let
  eDP = "00ffffffffffff0006102fa00000000004190104a5211578026fb1a7554c9e250c505400000001010101010101010101010101010101ef8340a0b0083470302036004bcf1000001a000000fc00436f6c6f72204c43440a20202000000010000000000000000000000000000000000010000000000000000000000000000000cf";
  dpLGWork = "00ffffffffffff001e6de476236605000b1b0104b55022789eca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a01a4020316712309060749100403011f13595a12830100009f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000000000000000000000000000000000000000000000000000000000000000aa";
  hdmiOld = "00ffffffffffff000469fd22c5a500002415010380301b782a2ac5a4564f9e280f5054b7ef00d1c0814081809500b300714f81c08100023a801871382d40582c4500dc0c1100001e000000ff0042394c4d54463034323433370a000000fd00324b185311000a202020202020000000fc00415355532056533232380a20200195020322714f0102031112130414050e0f1d1e1f10230917078301000065030c0010008c0ad08a20e02d10103e9600dc0c11000018011d007251d01e206e285500dc0c1100001e011d00bc52d01e20b8285540dc0c1100001e8c0ad090204031200c405500dc0c11000018000000000000000000000000000000000000000000b5";

  autorandr = {
    enable = true;
    profiles = {
      "work-monitor" = {
        fingerprint = {
          "eDP" = eDP;
          "DisplayPort-0" = dpLGWork;
        };
        config = {
          "eDP".enable = false;
          "DisplayPort-1".enable = false;
          "HDMI-0".enable = false;

          "DisplayPort-0" = {
              enable = true;
              primary = true;
              mode = "3440x1440";
              rate = "59.97";
          };
        };
      };
      "work-monitor-closed" = {
        fingerprint = {
          "DisplayPort-0" = dpLGWork;
        };
        config = {
          "eDP".enable = false;
          "DisplayPort-1".enable = false;
          "HDMI-0".enable = false;

          "DisplayPort-0" = {
              enable = true;
              primary = true;
              mode = "3440x1440";
              rate = "59.97";
          };
        };
      };
      "hdmi-old" = {
        fingerprint = {
          "eDP" = eDP;
          "HDMI-0" = hdmiOld;
        };
        config = {
          "DisplayPort-0".enable = false;
          "DisplayPort-1".enable = false;

          "eDP" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "2880x1800";
              rate = "59.99";
          };


          "HDMI-0" = {
              enable = true;
              position = "2880x0";
              mode = "1920x1080";
              rate = "60.00";
          };
        };
      };
      "stand-alone" = {
        fingerprint = {
          "eDP" = eDP;
        };
        config = {
          "DisplayPort-0".enable = false;
          "DisplayPort-1".enable = false;
          "HDPI-0".enable = false;

          "eDP" = {
              enable = true;
              primary = true;
              mode = "2880x1800";
              rate = "59.99";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "fix-background" = "${pkgs.feh}/bin/feh --bg-fill /home/piet/.background-image.png";
        "bspwm restart" = "${pkgs.bspwm}/bin/bspc wm --restart";
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