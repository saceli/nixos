{ lib, ... }:

let
  maxVMs = 64;

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