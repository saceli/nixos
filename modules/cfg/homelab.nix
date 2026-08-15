{ config, lib, ... }:

{
  options.cfg.homelab = {

    upInterface = lib.mkOption {
      type = lib.types.str;
      default = "end0";
      description = "Uplink interface for NAT and external connectivity";
    };

  };

  options.cfg.homelab.microvm = {
    hostPlatform = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-linux";
      description = "Host platform for MicroVMs";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05"; # do not edit! ever!
      description = "NixOS state version for MicroVMs";
    };

    authorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1UsmZD8Y1N4ydHo3ob2PgTgNPe7VxwlVaD8XtmVgwP elia@nixodactyl" ];
      description = "SSH authorized keys for MicroVM root";
    };

  };


}
