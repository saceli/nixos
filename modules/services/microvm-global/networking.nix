{ lib, ... }:

let
  maxVMs = 8; # i surely won't make any more than 8 vms, so i save up build time by making the maxVMs to 8
in
{

  systemd.network.networks = builtins.listToAttrs (
    map (index: {
      name = "30-vm${toString index}";
      value = {
        matchConfig.Name = "vm${toString index}";
        address = [
          "10.0.0.0/32"
          "fec0::/128"
        ];
        routes = [
          { Destination = "10.0.0.${toString index}/32"; }
          { Destination = "fec0::${lib.toHexString index}/128"; }
        ];
        networkConfig = {
          IPv4Forwarding = true;
          IPv6Forwarding = true;
        };
      };
    }) (lib.genList (i: i + 1) maxVMs)
  );

}
