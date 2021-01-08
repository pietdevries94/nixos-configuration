let
  eDP = "00ffffffffffff0006102fa00000000004190104a5211578026fb1a7554c9e250c505400000001010101010101010101010101010101ef8340a0b0083470302036004bcf1000001a000000fc00436f6c6f72204c43440a20202000000010000000000000000000000000000000000010000000000000000000000000000000cf";
  dpLGWork = "00ffffffffffff001e6de476236605000b1b0104b55022789eca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a01a4020316712309060749100403011f13595a12830100009f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000000000000000000000000000000000000000000000000000000000000000aa";

  profiles = {
    "work-monitor" = {
      fingerprint = {
        "eDP" = eDP;
        "DisplayPort-0" = dpLGWork;
      };
      config = {
        "eDP".enable = false;
        "DisplayPort-1".enable = false;
        "HDPI-0".enable = false;

        "DisplayPort-0" = {
            enable = true;
            primary = true;
            mode = "3440x1440";
            rate = "59.97";
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
in
{
  home-manager.users.piet = {
    xsession.profileExtra = ''
      autorandr --change
    '';
    programs.autorandr = {
      enable = true;
      inherit profiles;
    };
  };

  services.autorandr = {
    enable = true;
    defaultTarget = "common";
  };
  home-manager.users.root.programs.autorandr = {
    enable = true;
    inherit profiles;
  };
}