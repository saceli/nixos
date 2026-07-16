{ pkgs, ... }:

let
  macchangerScript = pkgs.writeShellScript "macchanger-auto" ''
    set -euo pipefail

    iface=""

    for i in /sys/class/net/*; do
      i=$(basename "$i")

      # Skip loopback
      [ "$i" = "lo" ] && continue

      # Skip virtual interfaces
      [ -d "/sys/class/net/$i/device" ] || continue

      iface="$i"
      break
    done

    if [ -z "$iface" ]; then
      echo "No physical network interface found."
      exit 1
    fi

    echo "Changing MAC address on $iface"

    ip link set "$iface" down
    macchanger -r "$iface"
    ip link set "$iface" up
  '';
in
{
  environment.systemPackages = with pkgs; [
    macchanger
  ];

  systemd.services.macchanger = {
    description = "Randomize MAC address";

    before = [ "NetworkManager.service" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [
      iproute2
      macchanger
      coreutils
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = macchangerScript;
      RemainAfterExit = true;
    };
  };
}