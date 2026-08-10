{ lib, config, ... }:

{
  networking.useNetworkd = true;

  cfg.homelab.upInterface = "wlan0"; # TODO: remove when prod

  # NAT for outbound internet access
  networking.nat = {
    enable = true;
    internalIPs = [ "10.0.0.0/24" ];
    externalInterface = config.cfg.homelab.upInterface;
  };
}
