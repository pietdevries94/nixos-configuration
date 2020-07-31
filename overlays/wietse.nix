self: super:
let
  wietse = import (fetchTarball https://github.com/wietsedv/personal-nixpkgs/archive/master.tar.gz) {};
in with wietse; {
  niq = niq;
}