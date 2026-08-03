{
  networking.networkmanager.enable = true;

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      "/root/secrets/home-wifi.env" # root:root 400 !!!
    ];

    profiles = {
      "home-wifi" = {
        connection = {
          id = "home-wifi";
          type = "wifi";
          autoconnect = true;
        };

        wifi = {
          mode = "infrastructure";
          ssid = "$WIFI_SSID";
        };

        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$WIFI_PASSWORD";
        };

        ipv4 = {
          method = "manual";
          addresses = "192.168.178.33/24";
          gateway = "192.168.178.1";
        };
        
      };
    };
  };
}