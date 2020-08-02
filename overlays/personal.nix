self: super:
let
  url = https://github.com/pietdevries94/personal-nix-channel/archive/master.tar.gz;
  personal = import (builtins.fetchTarball url) {
    config.allowUnfree = true;
  };
in personal
