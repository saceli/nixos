{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.podman
  ];

  virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "podman";

}
