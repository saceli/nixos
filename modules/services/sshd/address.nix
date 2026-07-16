{ config, lib, ... }:

{

  services.openssh = {

    # ssh address
    settings.ListenAddress = "0.0.0.0";

    # ssh port
    ports = lib.mkForce [ 22 ];

    # do not automatically open the ports
    openFirewall = false;

  };

}
