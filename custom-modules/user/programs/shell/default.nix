{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.custom.user.programs.shell;
in {
  options.custom.user.programs.shell = {
    enable = mkEnableOption "The user his personal shell setup";
  };

  config = mkIf cfg.enable {
    home-manager.users.piet = {
      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        history.path = ".zsh_history/history";
        initExtra = ''
          function c() {
            pushd && cd $@ && code . && popd
          }

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
          bindkey "$terminfo[kcuu1]" history-substring-search-up
          bindkey "$terminfo[kcud1]" history-substring-search-down

          export PATH=$PATH:$HOME/go/bin:$HOME/.local/bin
        '';
        shellAliases = {
          tmp = "pushd && cd $(mktemp -d)";
          l = "ls -lah";
          xm = "systemctl --user restart xmodmap.service && exit";
        };
        plugins = [
          {
            name = "zsh-history-substring-search";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-history-substring-search";
              rev = "v1.0.2";
              sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
            };
          }
          {
            name = "zsh-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-syntax-highlighting";
              rev = "0.7.1";
              sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
            };
          }
        ];
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          nix_shell = {
            symbol = "❄️ ";
          };
        };
      };

      services.lorri.enable = true;
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        stdlib = ''
          use_flake() {
            watch_file flake.nix
            watch_file flake.lock
            eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
          }
        '';
      };
    };

    custom.impermanence = {
      userDirectories = [
        { directory = ".local/share/direnv"; user = "piet"; }
        { directory = ".zsh_history"; mode = "0700"; user = "piet"; }
      ];
    };
  };
}
