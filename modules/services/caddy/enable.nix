{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
  };
  
  # for certutil
  environment.systemPackages = [
    pkgs.nss
  ];
}
