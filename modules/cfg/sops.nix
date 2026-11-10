{ lib, ... }:

{
  options.cfg.sops = {
    ageKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "/root/secrets/sops/keys.txt";
      description = "Path to the age key file used by sops-nix (sops.age.keyFile).";
    };

    defaultFormat = lib.mkOption {
      type = lib.types.str;
      default = "yaml";
      description = "Default format of the sops secrets files (sops.defaultSopsFormat).";
    };
  };
}
