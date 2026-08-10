{ lib, ... }:

let
  index = 1; # Change for every vm
  mac = "00:00:00:00:00:01"; # Change for every vm
in
{
  microvm.vms.searxng = {
    config = {

      imports = [
        ./oci-containers.nix
        config.microvm.globalOptions 
      ];

      microvm = {

        networking.firewall.allowedTCPPorts = [ 8080 ];

    };
  };
}
