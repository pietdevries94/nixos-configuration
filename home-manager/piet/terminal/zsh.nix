{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
      function nix-tmp() {                                                                                                                       ~
        nix-shell -p $@ --run zsh
      }

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down
    '';
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
}
