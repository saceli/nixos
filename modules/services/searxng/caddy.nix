{
  config,
  lib,
  ...
}: let
  homelab-ip = lib.strings.trim (builtins.readFile ../../../srv/homelab-ip.txt);
  securityHeaders = ''
    header {
      Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
      X-Content-Type-Options "nosniff"
      X-Frame-Options "DENY"
      Referrer-Policy "strict-origin-when-cross-origin"
    }
  '';
in {
  services.caddy.virtualHosts."search.home" = {
    listenAddresses = [ "0.0.0.0" ];

    serverAliases = [
      "search.lan"
      "www.search.lan"
      "www.search.home"
    ];

    # since searxng is just http, we don't route the port via nat.forwardPorts, since thats for raw layer 3/4
    # caddy handles http so we save ourselves the hassle and just raw-route the vm ip to port 8001 on the host's ip
    extraConfig = '' 
      ${securityHeaders}
      reverse_proxy 10.0.0.1:8080
      tls internal
    '';
  };
}