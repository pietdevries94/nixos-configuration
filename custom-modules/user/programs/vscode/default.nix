{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.vscode;
in {
  options.custom.user.programs.vscode = {
    enable = mkEnableOption "VS Code";
    theme = {
      name = mkOption {
        type = types.str;
      };
      extension = mkOption {
        type = types.package;
        default = null;
      };
    };
    languages = {
      golang = mkOption {
        type = types.bool;
        default = false;
      };
      rust = mkOption {
        type = types.bool;
        default = false;
      };
      vue = mkOption {
        type = types.bool;
        default = false;
      };
      svelte = mkOption {
        type = types.bool;
        default = false;
      };
      web = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      home.packages = [pkgs.victor-mono];
      programs.vscode = mkMerge [
        {
          enable = true;
          extensions = (with pkgs.extra-vscode-extensions; [
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
            jnoortheen.nix-ide
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
            "workbench.colorTheme" = cfg.theme.name;
            "workbench.iconTheme" = "vscode-icons";
            "nix.enableLanguageServer" = true;
            "editor.fontLigatures" = true;

            # "editor.fontFamily" = "'Victor Mono', 'monospace', monospace, 'Font Awesome 5 Free Solid', 'Inconsolata Nerd Font'";
            # "editor.fontSize" = 16;
            # "editor.fontWeight" = 500;
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
        }

        (mkIf (cfg.theme.extension != null) {
          extensions = [ cfg.theme.extension ];
        })

        (mkIf cfg.languages.golang {
          extensions = with pkgs.extra-vscode-extensions; [
            golang.go
          ];
          userSettings = {
            "go.formatTool" = "goimports";
          };
        })

        (mkIf cfg.languages.rust {
          extensions = with pkgs.extra-vscode-extensions; [
            matklad.rust-analyzer
          ];
        })

        (mkIf cfg.languages.vue {
          extensions = with pkgs.extra-vscode-extensions; [
            octref.vetur
            dbaeumer.vscode-eslint
            znck.vue-language-features
            graphql.vscode-graphql
          ];
        })

        (mkIf cfg.languages.svelte {
          extensions = with pkgs.extra-vscode-extensions; [
            svelte.svelte-vscode
          ];
        })

        (mkIf cfg.languages.web {
          extensions = with pkgs.extra-vscode-extensions; [
            voorjaar.windicss-intellisense
          ];
        })
      ];
    };
  };
}