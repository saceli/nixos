{ sops-nix, ... }:

{
  sops.secrets.searxng_secret_key = {
    sopsFile = ../../secrets/raspi/secrets.yaml;
    key = "searxng/secret_key";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/microvm/searxng 0755 root root -"
    "L+ /var/lib/microvm/searxng/secret_key - - - - ${config.sops.secrets.searxng_secret_key.path}"
  ];
}