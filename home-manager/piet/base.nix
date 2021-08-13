{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    niq
    niv
    unzip
    nix-boilerplate
  ];

  imports = [ 
    ./terminal/ssh.nix
    ./terminal/git.nix
    ./terminal/gpg-agent.nix
  ];
}
