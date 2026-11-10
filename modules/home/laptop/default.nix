{ config, wallpapers, ... }:

{
  hjem = {

    specialArgs = {
      inherit
        wallpapers
        ;
    };

    users.${config.cfg.user.username} = {
      enable = true;

      # per-user module imports
      imports = [
        ./files.nix
        ./wallpapers.nix
        ../universal-configs
      ];
    };
  };
}
