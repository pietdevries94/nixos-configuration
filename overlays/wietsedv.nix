self: super:
let
  url = https://github.com/wietsedv/personal-nixpkgs/archive/master.tar.gz;
  wietsedv = import (fetchTarball url) {};
in with wietsedv; {
  inherit niq;
}