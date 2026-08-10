{ config, ... }:

let
  index = 1;
  mac = "00:00:00:00:00:01";
in
{
  microvm.vms.searxng = {
    config = {

      _module.args = {
        inherit index mac;
      };

      imports = [
        ./oci-containers.nix
        config.microvm.globalOptions
      ];

      microvm.networking.firewall.allowedTCPPorts = [ 8080 ];
    };
  };
}