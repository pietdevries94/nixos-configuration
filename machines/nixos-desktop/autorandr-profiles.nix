let
  dviIiyama = "00ffffffffffff0026cd1461b50400002c18010380351e782a1b45a655509c260f5054330800710081408180a940b3009500d1c00101023a801871382d40582c4500132b2100001e000000ff0031313238303434343031323035000000fd00374c1e5311000a202020202020000000fc00504c5832343833480a2020202000b8";
  hdmiLG = "00ffffffffffff001e6df1598f9c0000011c010380431c78eaca95a6554ea1260f5054a54b80714f818081c0a9c0b300010101010101295900a0a038274030203a00a5222100001a023a801871382d40582c4500a11c2100001e000000fc004c4720554c545241574944450a000000fd00284b5a5a18000a20202020202001e1020325f1499004031412051f0113230907078301000065030c001000681a000001012d4b00023a801871382d40582c450056512100001e011d8018711c1620582c250056512100009e011d007251d01e206e28550056512100001e8c0ad08a20e02d10103e960056512100001800000000000000000000000000000000000097";
  hdmiLGWork = "00ffffffffffff001e6df676236605000b1b010380502278eaca95a6554ea1260f50542108007140818081c0a9c0b300d1c081000101e77c70a0d0a0295030203a00204f3100001a9d6770a0d0a0225030203a00204f3100001a000000fd00383d1e5a20000a202020202020000000fc004c4720554c545241574944450a017c02031ef12309070749100403011f13595a128301000067030c00100038409f3d70a0d0a0155030203a00204f3100001a7e4800e0a0381f4040403a00204f31000018011d007251d01e206e285500204f3100001e8c0ad08a20e02d10103e9600204f31000018000000ff003731314e54435a41443832370a000000000000001c";
in
{
  home-manager.users.piet = {
    xsession.profileExtra = ''
      autorandr --change
    '';
    programs.autorandr = {
      enable = true;
      profiles = {
        "default" = {
          fingerprint = {
            "HDMI-A-0" = hdmiLG;
            "DVI-D-0" =dviIiyama;
          };
          config = {
            "DisplayPort-0".enable = false;
            "DVI-D-1".enable = false;

            "HDMI-A-0" = {
                enable = true;
                primary = true;
                mode = "2560x1080";
                position = "1920x0";
                rate = "74.99";
            };

            "DVI-D-0" = {
                enable = true;
                mode = "1920x1080";
                position = "0x0";
                rate = "60.00";
            };
          };
        };
        "work-monitor" = {
          fingerprint = {
            "HDMI-A-0" = hdmiLGWork;
            "DVI-D-0" = dviIiyama;
          };
          config = {
            "DisplayPort-0".enable = false;
            "DVI-D-1".enable = false;

            "HDMI-A-0" = {
                enable = true;
                primary = true;
                mode = "3440x1440";
                position = "1920x0";
                rate = "59.97";
            };

            "DVI-D-0" = {
                enable = true;
                mode = "1920x1080";
                position = "0x0";
                rate = "60.00";
                # rotate = "left";
            };
          };
        };
      };
    };
  };
}