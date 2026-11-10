{ config, sops-nix, ... }:

{
  sops.defaultSopsFormat = config.cfg.sops.defaultFormat;
  sops.age.keyFile = config.cfg.sops.ageKeyFile;
}
