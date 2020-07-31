{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git pkgs.niv pkgs.unzip ];

  imports = [ 
    ./terminal/lorri.nix
    ./terminal/zsh.nix
  ];
}
