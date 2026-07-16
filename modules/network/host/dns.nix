{ config, lib, ... }:

let
  text = ''
    nameserver 1.1.1.1
    nameserver 1.0.0.1
  '';
in
{
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".text = lib.mkForce text;
}