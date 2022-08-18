self: super:
let
  url = https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz;
  unstable = import (fetchTarball url) {
    config.allowUnfree = true;
  };
in with unstable; {
  inherit
    inconsolata-nerdfont
    siji
    starship
    niv
    sweet
    numix-icon-theme
    firefox-bin
    vscode
    vscode-extensions
    minecraft
    insomnia
    prusa-slicer
    glab
    cura
    nixFlakes
    tela-icon-theme
    ferdium
  ;
}
