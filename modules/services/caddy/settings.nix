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
}
