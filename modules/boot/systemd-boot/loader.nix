{
  # bootloader - systemd-boot
  boot.loader.systemd-boot.enable = true; # will be forced false if systemd-boot is used with lanzaboote
  boot.loader.efi.canTouchEfiVariables = true;

  # set a respectable bootloader resolution
  boot.loader.systemd-boot.consoleMode = "max";

  # limit entries to 20
  boot.loader.systemd-boot.configurationLimit = 20;

  # prevent tampering boot parameters
  boot.loader.systemd-boot.editor = false;
}