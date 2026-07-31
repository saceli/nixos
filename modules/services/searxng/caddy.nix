{ config, lib, ... }:

let
  homelab-ip = lib.strings.trim (builtins.readFile ../../../srv/homelab-ip.txt);
in
{
  services.caddy.virtualHosts."search.home" = {
    listenAddresses = [ homelab-ip ];

    serverAliases = [
      "search.lan"
      "www.search.lan"
      "www.search.home"
    ];

    extraConfig = ''
      import security_headers
      reverse_proxy 127.0.0.1:8001
      tls internal
    '';
  };
}