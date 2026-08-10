# usage:

/*
{ config, ... }:

let
  index = 1; # change per vm
  mac = "00:00:00:00:00:01"; # change per vm
in
{
  microvm.vms.NAMEOFVM = {
    config = {
      
      _module.args = {
        inherit index mac;
      };

      imports = [
        config.microvm.globalOptions
      ];

      # other options here

    };
  };
}

*/

{ config, lib, index, mac, ... }:

{
  options.microvm.globalOptions = lib.mkOption {
    type = lib.types.deferredModule;
    default = { };
    description = "Global configuration applied to MicroVMs.";
  };

  config.microvm.globalOptions = {
    microvm = {
      hypervisor = "qemu";
      vcpu = 1;
      mem = 512;
      storeOnDisk = false;

      interfaces = [
        {
          type = "tap";
          id = "vm${toString index}";
          inherit mac;
          tap.vhost = true;
        }
      ];

      shares = [
        {
          tag = "ro-store";
          source = "/nix/store";
          mountPoint = "/nix/store";
          proto = "virtiofs";
          readOnly = true;
        }
      ];

      fileSystems."/" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [
          "defaults"
          "mode=755"
          "size=50%"
        ];
      };

      systemd.tmpfiles.rules = [
        "d /var/lib/containers 0755 root root -"
      ];

      systemd.network.networks."10-eth" = {
        matchConfig.MACAddress = mac;
        # Static IP configuration
        address = [
          "10.0.0.${toString index}/32"
          "fec0::${lib.toHexString index}/128"
        ];
        routes = [
          {
            # A route to the host
            Destination = "10.0.0.0/32";
            GatewayOnLink = true;
          }
          {
            # Default route
            Destination = "0.0.0.0/0";
            Gateway = "10.0.0.0";
            GatewayOnLink = true;
          }
          {
            # Default route
            Destination = "::/0";
            Gateway = "fec0::";
            GatewayOnLink = true;
          }
        ];
        networkConfig = {
          DNS = [
            # cloudflare dns
            "1.1.1.1"
            "1.0.0.1"
            "2606:4700:4700::1111"
            "2606:4700:4700::1001"
          ];
        };
      };

      nixpkgs.hostPlatform = config.cfg.homelab.microvm.hostPlatform;
      system.stateVersion = config.cfg.homelab.microvm.stateVersion;

      services.timesyncd = {
        enable = true;
        servers = [ "time.cloudflare.com" ];
      };

      microvm.vsock.cid = 1000 + index; # 1001-1999 based on index

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = "prohibit-password";
        settings.PasswordAuthentication = false;
        startWhenNeeded = true;
      };

      networking.hostName = "guest";
      networking.useDHCP = false;

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

      users.users.root.openssh.authorizedKeys.keys = lib.splitString "\n" (
        builtins.readFile config.cfg.homelab.microvm.authorizedKeysFile
      );
    };
  };
}
