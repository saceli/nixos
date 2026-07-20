{ wallpapers, ... }:

{
  hjem = {

    specialArgs = {
      inherit
        wallpapers;
    };

    users = {
      elia = {
        enable = true;

        # per-user module imports
        imports = [
          ./files.nix
          ./wallpapers.nix
          ../universal-configs
        ];
      }; 
    }; 
  }; 
}
