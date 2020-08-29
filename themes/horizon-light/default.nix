{ pkgs }:

# colors scheme from https://gitlab.com/horizon/horizon-vscode/-/blob/master/source/light/colors.json
let
  colors = {
    normal = {
      black = "#06060C";
      white = "#FADAD1";
      blue = "#26BBD9";
      cyan = "#59E1E3";
      green = "#29D398";
      magenta = "#EE64AC";
      red = "#E95678";
      yellow = "#FAB795";
    };
    bright = {
      black = "#817b7c";
      white = "#FDF0ED";
      blue = "#3FC4DE";
      cyan = "#6BE4E6";
      green = "#3FDAA4";
      magenta = "#F075B5";
      red = "#EC6A88";
      yellow = "#FBC3A7";
    };
    syntax = {
      amethyst = "#8A31B9";
      crimson = "#DA103F";
      elm = "#1D8991";
      thunderbird = "#DC3318";
      tango = "#F6661E";
      jaffa = "#F77D26";
      black = "#333333";
    };
    ui = rec {
      shadow = "#16161C";
      border = "#1A1C23";
      background = "#FDF0ED";
      backgroundAlt = "#FADAD1";
      accent = "#F9CBBE";
      accentAlt = "#F9CEC3";
      secondaryAccent = "#E73665";
      secondaryAccentAlt = "#E84A72";
      tertiaryAccent = "#AF5427";
      positive = "#07DA8C";
      negative = "#F43E5C";
      warning = "#1EB980";
      modified = "#1EAEAE";
      lightText = "#D5D8DA";
      darkText = "#06060C";
      foreground = darkText;
    };
  };
in {
  wallpaper = ./Norway.png;
  vscode = {
    themeExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "horizon-vscode";
      publisher = "Bauke";
      version = "3.0.3";
      sha256 = "0njdlmvrb8pdk81bv92dppvn3jgqhfc7zx6f349f11yxwgs9hwsr";
    };
    themeName = "Horizon Light";
  };

  gtk = {
    theme = {
      package = pkgs.qogir-theme;
      name = "Qogir Light";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
    };
  };

  colors = colors;
}
