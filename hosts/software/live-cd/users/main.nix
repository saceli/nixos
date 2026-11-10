{ config, ... }:

{
  # configuration for the main user and their group

  users.users.${config.cfg.user.username} = {

    home = "/home/${config.cfg.user.username}";

    isNormalUser = true;
    password = config.cfg.user.liveCdPassword;

    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "dialout"
    ];

  };

}
