{ config, lib, ... }:

{
  options.cfg.user = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "Username";
    };

    hashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Password hash. If null, SOPS is used.";
    };

    avatar = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Profile picture of the main user, used by AccountsService. If null, no profile picture is configured.";
    };

    liveCdPassword = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Plain-text password of the main user on the live-cd host.";
    };

    sops.hashedPasswordKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "SOPS key containing the user's password hash.";
    };
  };

  config.assertions = [
    {
      assertion =
        config.cfg.user.hashedPassword != null
        || config.cfg.user.sops.hashedPasswordKey != null;

      message = "cfg.user: either hashedPassword or sops.hashedPasswordKey must be set.";
    }

    {
      assertion =
        !(config.cfg.user.hashedPassword != null
          && config.cfg.user.sops.hashedPasswordKey != null);

      message = "cfg.user: hashedPassword and sops.hashedPasswordKey cannot both be set.";
    }
  ];
}
