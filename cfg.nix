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
        hashedPasswordKey = "laptop-amd64/elia/passwordHash";
      };
    };
  };
}