{
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    globalConfig = ''
      admin off
    '';
  };

  networking.firewall.allowedTCPPorts = [80 443];

  systemd.services.caddy = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
