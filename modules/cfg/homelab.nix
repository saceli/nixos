{ lib, ... }:

{
  options.cfg.homelab = {

    upInterface = lib.mkOption {
      type = lib.types.str;
      default = "end0";
      description = "Uplink interface for NAT and external connectivity";
    };

  };

}
