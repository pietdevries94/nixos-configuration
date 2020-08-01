self: super:
let
  unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {
    config.allowUnfree = true; 
  };
in with unstable; {
  inherit spotify
          inconsolata-nerdfont
          siji
          starship
          picom
  ;
}