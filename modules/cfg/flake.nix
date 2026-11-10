{ config, lib, ... }:

{
  options.cfg.flake = {

    absolutePath = lib.mkOption {
      type = lib.types.path;
      default = /. + "/home/${config.cfg.user.username}/nixos";
      description = "Local flake path, the path you use to `nixos-rebuild THISPATH#outputName`";
    };

  };

}
