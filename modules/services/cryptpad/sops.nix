{ config, ... }:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/cryptpad 0755 root root -"
    "d /var/lib/cryptpad/blob 0755 root root -"
    "d /var/lib/cryptpad/block 0755 root root -"
    "d /var/lib/cryptpad/data 0755 root root -"
    "d /var/lib/cryptpad/datastore 0755 root root -"
  ];
}