self: super:
let
  unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {
    config.allowUnfree = true; 
  };
in with unstable; {
   spotify = spotify;
   inconsolata-nerdfont = inconsolata-nerdfont;
   siji = siji;
   starship = starship;
   picom = picom;
}