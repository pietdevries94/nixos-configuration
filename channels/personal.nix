let 
  personalTarball = fetchTarball https://github.com/pietdevries94/personal-nix-channel/archive/master.tar.gz;
  personal = import personalTarball { };
in
  personal