{ config, lib, ... }:

{
  config = lib.mkIf (config.cfg.user.sops.hashedPasswordKey != null) {
    sops.secrets.userPasswordHash = {
      sopsFile = ../../../secrets/secrets.yaml;
      key = config.cfg.user.sops.hashedPasswordKey;
      neededForUsers = true;
    };
  };
}
