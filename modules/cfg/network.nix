{ lib, ... }:

{
  options.cfg.network.dnsServers = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    description = "DNS nameservers written to /etc/resolv.conf.";
  };

  options.cfg.wifiSSIDSopsKey = lib.mkOption {
    type = lib.types.str;
    description = "Wifi SSID";
  };

  options.cfg.wifiPasswordSopsKey = lib.mkOption {
    type = lib.types.str;
    description = "Wifi Password";
  };

}
