{ config, pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;

  programs.bash.initExtra = ''
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
  '';
}
