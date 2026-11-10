{ config, ... }:

{
  hjem = {
    users.${config.cfg.user.username} = {
      enable = true;

      # per-user module imports
      imports = [
        ../universal-configs # A raspi server doesnt really need much individual configs
      ];
    };
  };

}
