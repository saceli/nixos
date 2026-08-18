{ config, ... }:

{
  cfg = {
    flake = {
      absolutePath = /. + "/home/${config.cfg.user.username}/nixos";
    };

    user = {
      username = "elia";
      hashedPassword = null;

      sops = {
        hashedPasswordKey = "raspi/elia/passwordHash";
      };
    };
  };
}
