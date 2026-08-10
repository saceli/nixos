{ lib, ... }:

let
  index = 1; # Change for every vm
in
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
          type = "tap";
          id = "vm${toString index}";
          mac = "00:00:00:00:00:01";
	  tap.vhost = true;
        }];

        shares = [
          {
            tag = "ro-store";
            source = "/nix/store";
            mountPoint = "/nix/store";
            proto = "virtiofs";
            readOnly = true;
          }
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


      microvm.vsock.cid = 100;

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "prohibit-password";
        settings.PasswordAuthentication = false;
        startWhenNeeded = true;
      };


      # nixos enables grub by default, we dont need it
      boot.loader.grub.enable = false;

      # kernel modules we require
      boot.initrd.kernelModules = [
        "virtio_mmio"
        "virtio_pci"
        "virtio_blk"
        "virtiofs"
        "vmw_vsock_virtio_transport"
      ];

      # modules that consume boot time but have rare use-cases
      boot.blacklistedKernelModules = [
        "rfkill"
        "intel_pstate"
        "drm"
      ];

      # use systemd initrd for startup speed
      boot.initrd.systemd.enable = lib.mkDefault true;

      # we only need one kernel console
      boot.kernelParams = [ "8250.nr_uarts=1" ];

      # not required
      boot.swraid.enable = lib.mkDefault false;

      # due to a bug in systemd-networkd: https://github.com/systemd/systemd/issues/29388
      # we cannot use systemd-networkd-wait-online.
      systemd.network.wait-online.enable = lib.mkDefault false;

      # not required
      boot.initrd.systemd.tpm2.enable = lib.mkDefault false;
      systemd.tpm2.enable = lib.mkDefault false;

      # consumes a lot of boot time
      systemd.services.mount-pstore.enable = false;

      # fails in normal usage
      systemd.generators.systemd-gpt-auto-generator = "/dev/null";

      # documentation is huge
      documentation.enable = lib.mkDefault false;

      # networkd is used due to some strange startup time issues with nixos's
      # homegrown dhcp implementation
      networking.useNetworkd = lib.mkDefault true;

      # no need for the nix package manager
      # this is later enforced by assertions
      nix.enable = lib.mkDefault false;

      # no need to enable switch-to-configuration.pl
      system.switch.enable = lib.mkDefault false;

      users.users.root.openssh.authorizedKeys.keys = 
        lib.splitString "\n" (builtins.readFile ../../../srv/microvm-authorized_keys);
    };
  };
}
