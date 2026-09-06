{ config, lib, ... }:

let
  index = 2;
  mac = "00:00:00:00:00:02";
in
{
  microvm.vms.cryptpad = {
    config = {

      imports = [
        ./oci-containers.nix
        (config.microvm.globalOptions { inherit index mac; authorizedKeys = config.cfg.homelab.microvm.globalAuthorizedKeys; })
      ];

      networking.firewall.allowedTCPPorts = [ 8002 ];

      microvm.mem = lib.mkForce 1024;

      microvm.shares = [
        {
          tag = "cryptpad-data";
          source = "/var/lib/cryptpad";
          mountPoint = "/var/lib/cryptpad";
          proto = "virtiofs";
        }
      ];

    };
  };
}