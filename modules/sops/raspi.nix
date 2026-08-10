{ sops-nix, config, ... }:

{
  sops.secrets.searxng_secret_key = {
    sopsFile = ../../secrets/raspi/secrets.yaml;
    key = "searxng/secret_key";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/searxng-secrets 0400 root root -"
    "C /var/lib/searxng-secrets/secret_key - - - - ${config.sops.secrets.searxng_secret_key.path}"
  ];
}
