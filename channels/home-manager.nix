let
  hmTarball = fetchTarball https://github.com/rycee/home-manager/archive/release-20.03.tar.gz;
  hm = import "${hmTarball}/nixos";
in
  hm