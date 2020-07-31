{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    niq
    niv
    unzip
  ];

  imports = [ 
    ./terminal/lorri.nix
    ./terminal/zsh.nix
  ];
}
