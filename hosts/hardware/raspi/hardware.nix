{ nixpkgs, ... }:

{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.loader.grub.enable = false;

  hardware.enableRedistributableFirmware = true;

  sdImage.compressImage = false;

  # anti raspi-bomber
  nix.settings.max-jobs = 1;
  nix.settings.cores = 1;

}
