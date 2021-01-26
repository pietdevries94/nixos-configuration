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
      gruntfuggly.todo-tree

      # Nix
      bbenoist.Nix
      
      # Golang
      golang.go

      # Rust
      matklad.rust-analyzer
      
      # Vue
      octref.vetur
      dbaeumer.vscode-eslint
      znck.vue-language-features
      bradlc.vscode-tailwindcss
      graphql.vscode-graphql
    ]);
    userSettings = {
      "editor.fontFamily" = "'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback', 'Font Awesome 5 Free Solid', 'Inconsolata Nerd Font'";
      "editor.formatOnSave" = true;
      "editor.tabSize" = 2;
      "git.allowForcePush" = true;
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.rebaseWhenSync" = true;
      "gitlens.currentLine.enabled" = false;
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = themeName;
    };
    keybindings = [
      {
        key = "f13";
        command = "workbench.action.showCommands";
      }
      {
        key = "f14";
        command = "workbench.action.quickOpen";
      }
    ];
  };
}
