{ lib, config, ... }:

{
  networking.useNetworkd = true;

  config.cfg.homelab.upInferface = "wlan0"; # TODO: remove when prod

  # NAT for outbound internet access
  networking.nat = {
    enable = true;
    internalIPs = [ "10.0.0.0/24" ];
    externalInterface = config.cfg.homelab.upInferface;
  };
}