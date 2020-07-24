let 
  unstableTarball = fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz;
  unstable = import unstableTarball { config.allowUnfree = true; };
in
  unstable