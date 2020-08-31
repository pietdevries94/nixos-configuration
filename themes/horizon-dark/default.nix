{ pkgs }:

# colors scheme from https://gitlab.com/horizon/horizon-vscode/-/blob/master/source/dark/colors.json
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
      lavender = "#B877DB";
      cranberry = "#E95678";
      turquoise = "#25B0BC";
      apricot = "#F09483";
      rosebud = "#FAB795";
      tacao = "#FAC29A";
      gray = "#BBBBBB";
    };
    ui = {
      shadow = "#16161C";
      border = "#1A1C23";
      background = "#1C1E26";
      backgroundAlt = "#232530";
      accent = "#2E303E";
      accentAlt = "#6C6F93";
      secondaryAccent = "#E9436D";
      secondaryAccentAlt = "#E95378";
      tertiaryAccent = "#FAB38E";
      positive = "#09F7A0";
      negative = "#F43E5C";
      warning = "#27D797";
      modified = "#21BFC2";
      lightText = "#D5D8DA";
      darkText = "#06060C";
      foreground = "#FADAD1";
      foregroundAlt = "#FDF0ED";
    };
  };
in {
  wallpaper = ./Ariane-5.png;
  vscode = {
    themeExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "horizon-vscode";
      publisher = "Bauke";
      version = "3.0.3";
      sha256 = "0njdlmvrb8pdk81bv92dppvn3jgqhfc7zx6f349f11yxwgs9hwsr";
    };
    themeName = "Horizon Dark";
  };

  gtk = {
    theme = {
      package = pkgs.sweet;
      name = "Sweet-mars";
    };
    iconTheme = {
      package = pkgs.numix-icon-theme;
      name = "Numix";
    };
  };

  colors = colors;
}