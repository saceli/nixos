{ ... }:

{
  microvm.vms.searxng = {
    config = {
      imports = [ ./oci-containers.nix ];

      microvm = {
        hypervisor = "qemu";
        vcpu = 1;
        mem = 512;
        storeOnDisk = false;

        interfaces = [{
          type = "user";
          id = "eth0";
        }];

        shares = [
          {
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/store";
          }
        ];

        forwardPorts = [
          { from = "host"; host.port = 8001; guest.port = 8080; protocol = "tcp"; }
        ];
      };

      fileSystems."/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [ "defaults" "mode=755" "size=50%" ];
      };

      systemd.tmpfiles.rules = [
        "d /var/lib/containers 0755 root root -"
      ];

      system.stateVersion = "26.05";
      nixpkgs.hostPlatform = "aarch64-linux";

      networking.hostName = "searxng-guest";
      networking.useDHCP = false;

      networking.firewall.allowedTCPPorts = [ 8080 ];

      services.timesyncd = {
        enable = true;
        servers = [ "time.cloudflare.com" ];
      };
    };
  };
}