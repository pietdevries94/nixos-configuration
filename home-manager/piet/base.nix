{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
