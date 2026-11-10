{ lib, ... }:

{
  options.cfg.hosts.laptop = {
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixosaurus";
      description = "Hostname of the laptop host.";
    };

    rootMapperName = lib.mkOption {
      type = lib.types.str;
      default = "nixosroot";
      description = "Name of the LUKS mapped device for the root filesystem, as it appears under /dev/mapper/.";
    };

    rootLuksUuid = lib.mkOption {
      type = lib.types.str;
      default = "778cb3cd-345c-4920-ad23-93ea93d5b278";
      description = "UUID of the LUKS container backing the root filesystem.";
    };

    bootPartitionUuid = lib.mkOption {
      type = lib.types.str;
      default = "05FA-F4DC";
      description = "UUID of the EFI system partition mounted at /boot.";
    };

    homeMapperName = lib.mkOption {
      type = lib.types.str;
      default = "nixoshome";
      description = "Name of the LUKS mapped device for the home filesystem, as it appears under /dev/mapper/ and in /etc/crypttab.";
    };

    homeLuksUuid = lib.mkOption {
      type = lib.types.str;
      default = "55628a09-46ca-4299-9b40-f9cf45395d16";
      description = "UUID of the LUKS container backing the home filesystem, used in /etc/crypttab.";
    };

    homeLuksKeySopsKey = lib.mkOption {
      type = lib.types.str;
      default = "laptop-amd64/elia/homeLuksKey";
      description = "Key inside the sops secrets file holding the LUKS key for the home filesystem.";
    };

    staticIpAddress = lib.mkOption {
      type = lib.types.str;
      default = "192.168.178.30/24";
      description = "Static IPv4 address (with CIDR prefix) of the home-wifi NetworkManager profile.";
    };
  };

  options.cfg.hosts.raspi = {
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixodactyl";
      description = "Hostname of the raspi host.";
    };

    compressSdImage = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the built SD image should be compressed (sdImage.compressImage).";
    };

    staticIpAddress = lib.mkOption {
      type = lib.types.str;
      default = "192.168.178.33/24";
      description = "Static IPv4 address (with CIDR prefix) of the home-wifi NetworkManager profile.";
    };
  };

  options.cfg.hosts.live-cd = {
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixosaurus";
      description = "Hostname of the live-cd host.";
    };
  };
}
