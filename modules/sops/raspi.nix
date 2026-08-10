{ sops-nix, ... }:

{
  sops.secrets.searxng_secret_key = {
    sopsFile = ../../secrets/raspi/secrets.yaml;
    key = "searxng/secret_key";
  };
}