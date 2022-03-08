{ pkgs, lib, config, ... }:

let
  eDP = "00ffffffffffff000e6f011600000000001e0104a522167803ee95a3544c99260f505400000001010101010101010101010101010101ffd700a0a0405e603020360059d710000018000000fd003078cbcb37010a202020202020000000fe0043534f542054330a2020202020000000fe004d4e473030374441312d320a200042";
  hdmiLuuk = "00ffffffffffff0006102fa00000000004190104a5211578026fb1a7554c9e250c505400000001010101010101010101010101010101ef8340a0b0083470302036004bcf1000001a000000fc00436f6c6f72204c43440a20202000000010000000000000000000000000000000000010000000000000000000000000000000cf";
  displayPortPatrick = "00ffffffffffff001e6df676beb003000b1b010380502278eaca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a019902031ef12309070749100403011f13595a128301000067030c00100038409f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000ff003731314e54555737333835340a0000000000000028";
  displayPortRick = "00ffffffffffff001e6df6763d6605000b1b010380502278eaca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a016202031ef12309070749100403011f13595a128301000067030c00100038409f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000ff003731314e545a4e41443835330a0000000000000012";
  displayPortWork = "00ffffffffffff001e6df676236605000b1b010380502278eaca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a017c02031ef12309070749100403011f13595a128301000067030c00100038409f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000ff003731314e54435a41443832370a000000000000001c";
  hdmi4k = "00ffffffffffff004c2d1810424a5843221f0103803f24782ac8b5ad50449e250f5054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a0078682100001e000000fd00283c1e873c000a202020202020000000fc004c5532385235350a2020202020000000ff0048345a523830333531390a202001aa02033ef04961120313041f10605f2309070783010000e305c0006b030c001000b83c2000200167d85dc401788003e20f81681a00000101283c00e3060501023a80d072382d40102c458078682100001e565e00a0a0a029503020350078682100001a04740030f2705a80b0588a0078682100001e00000000000000000000003a";

  autorandr = {
    enable = true;
    profiles = {
      "home-4k" = {
        fingerprint = {
          "eDP" = eDP;
          "HDMI-A-0" = hdmi4k;
        };
        config = {
          "HDMI-A-0" = {
              enable = true;
              primary = true;
              mode = "3840x2160";
              position = "0x0";
              rate = "60.00";
              dpi = 128;
          };
          "eDP" = {
              enable = true;
              mode = "2560x1600";
              position = "3840x0";
              rate = "120.01";
              dpi = 128;
          };
        };
      };
      "work-monitor" = {
        fingerprint = {
          "eDP" = eDP;
          "DisplayPort-0" = displayPortWork;
        };
        config = {
          "eDP" = {
            enable = true;
            mode = "2560x1600";
            position = "3440x0";
            rate = "120.01";
          };
          "DisplayPort-0" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "work-monitor-closed" = {
        fingerprint = {
          "DisplayPort-0" = displayPortWork;
        };
        config = {
          "eDP".enable = false;
          "DisplayPort-0" = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "work-rick-monitor" = {
        fingerprint = {
          "eDP" = eDP;
          "DisplayPort-0" = displayPortRick;
        };
        config = {
          "eDP" = {
            enable = true;
            mode = "2560x1600";
            position = "3440x0";
            rate = "120.01";
          };
          "DisplayPort-0" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "work-rick-monitor-closed" = {
        fingerprint = {
          "DisplayPort-0" = displayPortRick;
        };
        config = {
          "eDP".enable = false;
          "DisplayPort-0" = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "3440x1440";
            rate = "49.99";
          };
        };
      };
      "work-patrick-monitor" = {
        fingerprint = {
          "eDP" = eDP;
          "DisplayPort-0" = displayPortPatrick;
        };
        config = {
          "eDP" = {
            enable = true;
            mode = "2560x1600";
            position = "0x0";
            rate = "120.01";
          };
          "DisplayPort-0" = {
            enable = true;
            primary = true;
            mode = "3440x1440";
            position = "2560x0";
            rate = "49.99";
          };
        };
      };
      "work-patrick-monitor-closed" = {
        fingerprint = {
          "DisplayPort-0" = displayPortPatrick;
        };
        config = {
          "eDP".enable = false;
          "DisplayPort-0" = {
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
        "bspwm restart" = lib.mkIf config.custom.user.xsession.bspwm.enable "${pkgs.bspwm}/bin/bspc wm --restart";
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
