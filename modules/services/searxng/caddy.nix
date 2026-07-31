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
    listenAddresses = [homelab-ip];

    serverAliases = [
      "search.lan"
      "www.search.lan"
      "www.search.home"
    ];

    extraConfig = ''
      ${securityHeaders}
      reverse_proxy 127.0.0.1:8001
      tls internal
    '';
  };
}
