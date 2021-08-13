{ ... }:

let
  hmTarball = fetchTarball https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz;
in {
  imports = [ 
    ../custom-modules
    (import "${hmTarball}/nixos")
  ];
  
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  virtualisation.oci-containers = {
    backend = "podman";
  };
}