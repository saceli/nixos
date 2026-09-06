{
  config,
  lib,
  ...
}:
let
  securityHeaders = ''
    header {
      Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
      X-Content-Type-Options "nosniff"
      X-Frame-Options "SAMEORIGIN"
      Referrer-Policy "strict-origin-when-cross-origin"
    }
  '';
in
{
  services.caddy.virtualHosts."${config.cfg.homelab.services.cryptpad.baseUrl}" = {
    listenAddresses = [ "0.0.0.0" ];

    serverAliases = config.cfg.homelab.services.cryptpad.urlAliases ++ [
      config.cfg.homelab.privateIp
    ];

    extraConfig = ''
      ${securityHeaders}
      reverse_proxy 10.0.0.2:8002
      tls internal
    '';
  };
}