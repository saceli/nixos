{ ... }:

{
  services.unbound = {
    enable = true;

    settings = {
      server = {
        interface = [
          "0.0.0.0"
        ];

        access-control = [
          "127.0.0.0/8 allow"
          "192.168.0.0/16 allow"
        ];

        hide-identity = true;
        hide-version = true;
      };

      forward-zone = [
        {
          name = ".";

          forward-addr = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        }
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      53
    ];

    allowedUDPPorts = [
      53
    ];
  };
}