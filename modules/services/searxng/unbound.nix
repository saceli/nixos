# BROKEN!

{lib, ...}: let
  homelab-ip = lib.strings.trim (builtins.readFile ../../../srv/homelab-ip.txt);
in {
  services.unbound.settings.server = {
    # Prevent leaking local names to the internet
    local-zone = [
      ''"home." static''
      ''"lan." static''
    ];

    local-data = [
      "search.home. IN A ${homelab-ip}"
      "search.lan. IN A ${homelab-ip}"
    ];
  };
}