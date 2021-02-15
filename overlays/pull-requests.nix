self: super:
let
  ads = import (fetchTarball https://github.com/pietdevries94/nixpkgs/archive/azuredatastudio-update-1.25.2.tar.gz) {
    config.allowUnfree = true;
  };
in {
  azuredatastudio = ads.azuredatastudio;
}