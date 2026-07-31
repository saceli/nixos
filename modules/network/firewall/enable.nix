{ lib, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.connectionTrackingModules = lib.mkForce [ ];
  networking.firewall.autoLoadConntrackHelpers = lib.mkForce false;
  networking.firewall.backend = "nftables";
  networking.firewall.allowPing = false;

}
