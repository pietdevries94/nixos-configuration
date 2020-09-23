{ themeExtension, themeName }:

{ config, pkgs, lib, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
      themeExtension
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "0.1.2";
      sha256 = "1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
    }
    {
      name = "go";
      publisher = "golang";
      version = "0.15.2";
      sha256 = "0whd0a97fd9l1rzw93r1ijr2kzmasvals9rrp5lk1j9iybxv4mf2";
    }
    {
      name = "color-highlight";
      publisher = "naumovs";
      version = "2.3.0";
      sha256 = "1syzf43ws343z911fnhrlbzbx70gdn930q67yqkf6g0mj8lf2za2";
    }
    {
      name = "gitlens";
      publisher = "eamodio";
      version = "10.2.2";
      sha256 = "00fp6pz9jqcr6j6zwr2wpvqazh1ssa48jnk1282gnj5k560vh8mb";
    }
  ];
in
{
  programs.vscode = {
    enable = true;
    extensions = extensions;
    userSettings = {
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback', 'Font Awesome 5 Free Solid', 'Inconsolata Nerd Font'";
      "editor.tabSize" = 2;
      "git.allowForcePush" = true;
      "git.confirmSync" = false;
      "git.rebaseWhenSync" = true;
      "gitlens.currentLine.enabled" = false;
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = themeName;
    };
  };
}
