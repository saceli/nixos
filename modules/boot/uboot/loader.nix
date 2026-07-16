{
  # nixos wants to enable grub by default
  boot.loader.grub.enable = false;

  # im paranoid lol
  boot.loader.systemd-boot.enable = false;

  # use the extlinux boot loader
  boot.loader.generic-extlinux-compatible.enable = true;

  # limit entries to 20
  boot.loader.generic-extlinux-compatible.configurationLimit = 20;
}