{ sops-nix, config, ... }:

{
  sops.secrets.elia-password-hash = {
    sopsFile = ../../secrets.yaml;
    key = "elia/passwordHash";
  };

  systemd.tmpfiles.rules = [
    "d /run/ 0400 root root -"
    "C /var/lib/searxng-secrets/secret_key - - - - ${config.sops.secrets.searxng_secret_key.path}"
  ];
}
