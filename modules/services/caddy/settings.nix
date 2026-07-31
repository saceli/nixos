{ config, lib, pkgs, ... }:

{
  services.caddy = {

    globalConfig = ''
      admin off

      # Common security headers snippet any virtual host can import
      (security_headers) {
        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
          X-Content-Type-Options "nosniff"
          X-Frame-Options "DENY"
          Referrer-Policy "strict-origin-when-cross-origin"
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}