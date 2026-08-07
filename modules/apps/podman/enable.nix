{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.podman
  ];
}
