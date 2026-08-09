{ nixpkgs, ... }:

{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.loader.grub.enable = false;

  boot.initrd.kernelModules = [
    "virtio_mmio"
    "virtio_pci"
    "virtio_blk"
    "virtiofs"
    "vmw_vsock_virtio_transport"
  ];

  hardware.enableRedistributableFirmware = true;

  sdImage.compressImage = false;

  # anti raspi-bomber
  nix.settings.max-jobs = 1;
  nix.settings.cores = 1;

  # hostname
  networking.hostName = "nixodactyl";

}
