{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    niq
    niv
    unzip
    nix-boilerplate
  ];

  imports = [ 
    ./terminal/lorri.nix
    ./terminal/zsh.nix
    ./terminal/ssh.nix
  ];
}
