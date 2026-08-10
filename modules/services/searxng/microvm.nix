{ config, lib, ... }:

let
  index = 1;
  mac = "00:00:00:00:00:01";
in
{
  microvm.vms.searxng = {
    config = {

      imports = [
        ./oci-containers.nix
        (config.microvm.globalOptions { inherit index mac; authorizedKeys = config.cfg.homelab.microvm.authorizedKeys; })
      ];

      networking.firewall.allowedTCPPorts = [ 8080 ];

      microvm.mem = lib.mkForce 1024;

      microvm.shares = [
        {
          tag = "searxng-secrets";
          source = "/var/lib/microvm/searxng/secrets";
          mountPoint = "/var/lib/searxng-secrets";
          proto = "virtiofs";
        }
      ];

    };
  };
}
