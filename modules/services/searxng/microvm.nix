{ ... }:

{
  microvm.vms.searxng = {
    config = {
      imports = [ ./oci-containers.nix ];

      microvm = {
        enable = true;
        hypervisor = "qemu";
        vcpu = 1;
        mem = 512;
        storeOnDisk = false;

        forwardPorts = [
          { from = "host"; host.port = 8001; guest.port = 8080; protocol = "tcp"; }
        ];
      };

      system.stateVersion = "26.05";
      nixpkgs.hostPlatform = "aarch64-linux";

      networking.hostName = "searxng-guest";
      networking.useDHCP = false;
      networking.interfaces.eth0.useDHCP = true;
      networking.firewall.allowedTCPPorts = [ 8080 ];

      services.timesyncd = {
        enable = true;
        servers = [ "time.cloudflare.com" ];
      };
    };
  };
}