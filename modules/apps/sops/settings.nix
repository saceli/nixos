{ sops-nix, ... }:

{
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/root/secrets/sops/keys.txt";
}