{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git pkgs.niv ];

  imports = [ 
    ./terminal/lorri.nix
    ./terminal/zsh.nix
  ];
}
