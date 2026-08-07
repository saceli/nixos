{ lib, ... }:

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
          mac = "02:00:00:00:00:01";
        }];

        shares = [
          {
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/store";
          }
        ];

        forwardPorts = [
          { from = "host"; host.port = 8001; guest.port = 8080; proto = "tcp"; }
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

      networking.firewall.allowedTCPPorts = [ 8080 22 ];

      services.timesyncd = {
        enable = true;
        servers = [ "time.cloudflare.com" ];
      };

      microvm.vsock.cid = 100;

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "prohibit-password";
        settings.PasswordAuthentication = false;
      };

      users.users.root.openssh.authorizedKeys.keys = 
        lib.splitString "\n" (builtins.readFile ../../../srv/authorized_keys);
    };
  };
}