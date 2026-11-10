{ config, lib, ... }:

{
  sops.secrets.homewifiSSID = {
    sopsFile = ../../../secrets/secrets.yaml;
    key = config.cfg.wifiSSIDSopsKey;
  };

  sops.secrets.homewifiPassword = {
    sopsFile = ../../../secrets/secrets.yaml;
    key = config.cfg.wifiPasswordSopsKey;
  };

  # Drop the networking.networkmanager.ensureProfiles block entirely
  sops.templates."home-wifi.nmconnection" = {
    path = "/etc/NetworkManager/system-connections/home-wifi.nmconnection";
    mode = "0600";        # keyfiles must be 0600 (or stricter) and not group/world readable
    owner = "root";
    group = "root";
    content = ''
      [connection]
      id=home-wifi
      type=wifi
      autoconnect=true

      [wifi]
      mode=infrastructure
      ssid=${config.sops.placeholder.homewifiSSID}

      [wifi-security]
      key-mgmt=wpa-psk
      psk=${config.sops.placeholder.homewifiPassword}

      [ipv4]
      method=manual
      address1=${config.cfg.hosts.laptop.staticIpAddress},192.168.178.1
      dns=192.168.178.1;

      [ipv6]
      method=auto
    '';
  };
}
