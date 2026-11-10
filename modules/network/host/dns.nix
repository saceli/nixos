{ config, lib, ... }:

let
  text = (lib.concatStringsSep "\n" (map (ns: "nameserver ${ns}") config.cfg.network.dnsServers)) + "\n";
in
{
  # disable auto generation of resolv.conf
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  # write a custom resolv.conf that works globally
  environment.etc."resolv.conf".text = lib.mkForce text;
}
