{ ... }:

{
  systemd.tmpfiles.rules = [
    "d /home/elia/.ssh 0700 elia users -"
    "f+ /home/elia/.ssh/authorized_keys 0600 elia users - ssh-ed25519 AAAAC3N1lZDI1NTE5AAAAIN1UsmZD8Y1N4ydHo3ob2PgTgNPe7VxwlVaD8XtmVgwP elia@nixodactyl"
  ];
}