let personal = import (builtins.fetchTarball {
  url = https://github.com/pietdevries94/personal-nix-channel/archive/master.tar.gz;
});
in personal
