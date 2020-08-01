self: super:
let
  wietsedv = import (fetchTarball https://github.com/wietsedv/personal-nixpkgs/archive/master.tar.gz) {};
in with wietsedv; {
  niq = niq;
}