{ config, ... }:

let
  index = 1;
  mac = "00:00:00:00:00:01";
in
{
  microvm.vms.searxng = {
    config = {

      imports = [
        ./oci-containers.nix
        (config.microvm.globalOptions { inherit index mac config; })
      ];

      networking.firewall.allowedTCPPorts = [ 8080 ];

    };
  };
}
