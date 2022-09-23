{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.vscode;
in {
  options.custom.user.programs.vscode = {
    enable = mkEnableOption "VS Code";
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
    custom.impermanence.userDirectories = [
      { directory = ".config/Code"; mode = "0700"; user = "piet"; }
    ];

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
            # vscode-icons-team.vscode-icons needs to be installed manually

            # Git
            cschleiden.vscode-github-actions
            github.vscode-pull-request-github
            GitLab.gitlab-workflow

            # Nix
            jnoortheen.nix-ide
          ]);
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
            {
              key = "f15";
              command = "nx.run.target";
            }
            {
              key = "f16";
              command = "nx.generate";
            }
          ];
        }

        (mkIf cfg.languages.golang {
          extensions = with pkgs.extra-vscode-extensions; [
            golang.go
          ];
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