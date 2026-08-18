{ config, pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;

  environment.variables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gcr/ssh";
}
