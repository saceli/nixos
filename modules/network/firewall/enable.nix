{ lib, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.connectionTrackingModules = lib.mkForce [ ];
  networking.firewall.autoLoadConntrackHelpers = lib.mkForce false;
  networking.firewall.backend = "nftables";
  networking.nftables.enable = true; # without this nix imports shitfuck modules for iptables so i crashed out for 30 minutes
  networking.firewall.allowPing = false;

}
