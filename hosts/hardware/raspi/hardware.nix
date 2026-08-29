{ nixpkgs, nixos-hardware, pkgs, lib, ... }:

{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
    nixos-hardware.nixosModules.raspberry-pi-4
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  hardware.enableRedistributableFirmware = true;

  sdImage.compressImage = false;

  # anti raspi-bomber
  nix.settings.max-jobs = 1;
  nix.settings.cores = 1;

  # hostname
  networking.hostName = "nixodactyl";

  # Create gpio group
  users.groups.gpio = {};

  # Change permissions gpio devices
  services.udev.extraRules = ''
    SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="gpio",MODE="0660"
    SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 220 /sys/class/gpio/export /sys/class/gpio/unexport'"
    SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 660 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
  '';

  # Add user to group
  users = {
    users.elia = {
      extraGroups = [ "gpio" "i2c" ];
    };
  };

  hardware.raspberry-pi."4".i2c1.enable = true;
  hardware.i2c.enable = true;
  hardware.raspberry-pi."4".gpio.enable = true;

  hardware.raspberry-pi.configtxt.settings = {
    all = {
      dtparam = [
        "dtoverlay=ssd1306"
        "i2c_arm=on"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    i2c-tools
    libgpiod_1
  ];

}
