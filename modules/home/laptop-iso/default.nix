{
  hjem = {
    users = {
      elia = {
        enable = true;

        # per-user module imports
        imports = [
          ./files.nix
          ../universal-configs
        ];
      }; 
    }; 
  }; 

}