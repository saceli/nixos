{ config, lib, ... }:

{
  options.cfg.flake = {

    absolutePath = lib.mkOption {
      type = lib.types.path;
      default = /. + "${config.users.users.elia.home}/nixos"; # TODO: make the elia user a cfg option
      description = "Local flake path, the path you use to `nixos-rebuild THISPATH#outputName`";
    };

  };

}
