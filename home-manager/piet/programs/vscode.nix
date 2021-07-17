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
      editorconfig.editorconfig
      emeraldwalk.runonsave
      pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
      # vscode-icons-team.vscode-icons needs to be installed manually

      # Git
      cschleiden.vscode-github-actions
      github.vscode-pull-request-github
      GitLab.gitlab-workflow

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
      graphql.vscode-graphql

      # Svelte
      svelte.svelte-vscode

      # General Web
      voorjaar.windicss-intellisense
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
      "workbench.iconTheme" = "vscode-icons";
      "go.formatTool" = "goimports";
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
      {
        key = "alt+left";
        command = "workbench.action.navigateBack";
      }
      {
        key = "alt+right";
        command = "workbench.action.navigateForward";
      }
    ];
  };
}
