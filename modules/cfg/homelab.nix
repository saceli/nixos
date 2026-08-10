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

    authorizedKeysFile = lib.mkOption {
      type = lib.types.path;
      default = config.cfg.flake.absolutePath + /.ssh/authorized_keys;
      description = "SSH authorized keys file for MicroVMs";
    };
  };


}
