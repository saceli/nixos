{...}: {
  services.unbound = {
    enable = true;

    settings = {
      server = {
        interface = ["0.0.0.0"];

        access-control = [
          "127.0.0.0/8 allow"
          "192.168.0.0/16 allow"
        ];

        hide-identity = true;
        hide-version = true;

        # Hardening
        harden-glue = true;
        harden-dnssec-stripped = true;
        harden-referral-path = true;
        harden-algo-downgrade = true;
        use-caps-for-id = true;
        qname-minimisation = true;

        # Performance / cache
        prefetch = true;
        prefetch-key = true;
        cache-min-ttl = 300;
        cache-max-ttl = 86400;
        rrset-cache-size = "128m";
        msg-cache-size = "64m";
        so-rcvbuf = "1m";
        so-sndbuf = "1m";

        # Privacy / security
        rrset-roundrobin = true;
        minimal-responses = true;
        deny-any = true;
        ratelimit = 1000; # queries per second per IP
      };

      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
          ];
          forward-tls-upstream = true;
        }
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };
}
