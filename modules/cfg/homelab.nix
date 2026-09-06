{ config, lib, ... }:

{
  options.cfg.homelab = {

    upInterface = lib.mkOption {
      type = lib.types.str;
      default = "wlan0";
      description = "always up interface for homelab (the interface that's always online, usually a ethernet interface like end0 or eth0)";
    };

    privateIp = lib.mkOption {
      type = lib.types.str;
      default = "192.168.178.33";
      description = "homelab static private ip";
    };

  };

  options.cfg.homelab.services.searxng = {
    
    baseUrl = lib.mkOption {
      type = lib.types.str;
      default = "search.saceli.dev";
      description = "homelab searxng base url";
    };

    urlAliases = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ 
        "search.lan"
        "www.search.lan"
        "www.search.home" 
      ];
      description = "SSH authorized keys for MicroVM root";
    };


  };

  options.cfg.homelab.microvm = {
    hostPlatform = lib.mkOption {
      type = lib.types.str;
      default = "aarch64-linux";
      description = "Host platform for MicroVMs";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05"; # do not edit! ever!
      description = "NixOS state version for MicroVMs";
    };

    globalAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1UsmZD8Y1N4ydHo3ob2PgTgNPe7VxwlVaD8XtmVgwP elia@nixodactyl" ];
      description = "SSH authorized keys for MicroVM root";
    };

  };

    options.cfg.homelab.services.cryptpad = {
    baseUrl = lib.mkOption {
      type = lib.types.str;
      default = "pad.saceli.dev";
      description = "homelab cryptpad base url";
    };

    urlAliases = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "pad.lan"
        "pad.home"
        "www.pad.lan"
        "www.pad.home"
        "${config.homelab.privateIp}:8002"
      ];
      description = "Cryptpad URL aliases";
    };
  };

}
