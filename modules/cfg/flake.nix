{ config, lib, ... }:

{
  options.cfg.flake = {

    absolutePath = lib.mkOption {
      type = lib.types.addCheck lib.types.path (p: builtins.pathExists p);
      default = builtins.toPath "${config.users.users.elia.home}/nixos"; # TODO: make the elia user a cfg option
      description = "Local flake path, the path you use to `nixos-rebuild THISPATH#outputName`";
    };

  };

}
