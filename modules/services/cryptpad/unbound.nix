{ lib, ... }:
let
  homelab-ip = lib.strings.trim (builtins.readFile ../../../srv/homelab-ip.txt);
in
{
  services.unbound.settings.server = {
    local-zone = [
      ''"home." static''
      ''"lan." static''
    ];

    local-data = [
      "pad.home. IN A ${homelab-ip}"
      "pad.lan. IN A ${homelab-ip}"
    ];
  };
}