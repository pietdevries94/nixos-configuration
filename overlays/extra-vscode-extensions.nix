self: super:
let
  url = https://github.com/pietdevries94/nix-vscode-extensions/archive/master.tar.gz;
  overlay = import (builtins.fetchTarball url) {};
in overlay
