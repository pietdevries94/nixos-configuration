{ themeExtension, themeName }:

{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = (with pkgs.extra-vscode-extensions; [
      themeExtension
      
      # General
      arrterian.nix-env-selector
      bungcip.better-toml
      eamodio.gitlens
      naumovs.color-highlight

      # Nix
      bbenoist.Nix
      
      # Golang
      golang.go

      # Rust
      matklad.rust-analyzer
      
      # Vue
      octref.vetur
    ]);
    userSettings = {
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback', 'Font Awesome 5 Free Solid', 'Inconsolata Nerd Font'";
      "editor.tabSize" = 2;
      "git.allowForcePush" = true;
      "git.confirmSync" = false;
      "git.rebaseWhenSync" = true;
      "gitlens.currentLine.enabled" = false;
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = themeName;
      "git.autofetch" = true;
    };
    keybindings = [
      {
        key = "f13";
        command = "workbench.action.showCommands";
      }
    ];
  };
}
