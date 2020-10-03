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
    picom
    niv
    sweet
    numix-icon-theme
    firefox-bin
    vscode-extensions
    minecraft
  ;
}