{ config, lib, ... }:

let
  text = ''
    nameserver 1.1.1.1
    nameserver 1.0.0.1
  '';
in
{
  # disable auto generation of resolv.conf
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  # write a custom resolv.conf that works globally
  environment.etc."resolv.conf".text = lib.mkForce text;
}