{ ... }:

{
  imports = [ ../custom-modules ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}