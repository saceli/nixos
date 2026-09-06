{
  config,
  pkgs,
  lib,
  ...
}:

{
  virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers.cryptpad = {
    image = "docker.io/cryptpad/cryptpad:latest";
    autoStart = true;
    ports = [ "0.0.0.0:8002:3000" ];
    volumes = [
      "/var/lib/cryptpad/blob:/cryptpad/blob"
      "/var/lib/cryptpad/block:/cryptpad/block"
      "/var/lib/cryptpad/data:/cryptpad/data"
      "/var/lib/cryptpad/datastore:/cryptpad/datastore"
    ];
    environment = {
      CPAD_MAIN_DOMAIN = "pad.home";
      CPAD_SANDBOX_DOMAIN = "pad.home";
    };

    extraOptions = [
      "--read-only"
      "--cap-drop=ALL"
      "--tmpfs=/tmp:rw,size=100M"
    ];
  };

  systemd.services."podman-cryptpad" = {
    after = [
      "network-online.target"
      "sops-nix.service"
      "systemd-tmpfiles-setup.service"
    ];
    wants = [
      "network-online.target"
      "sops-nix.service"
      "systemd-tmpfiles-setup.service"
    ];
    requires = [ "systemd-tmpfiles-setup.service" ];
  };
}