{ config, lib, ... }:

{
  users.users.${config.cfg.user.username} = {
    home = "/home/${config.cfg.user.username}";

    isNormalUser = true;

    hashedPassword = lib.mkIf (config.cfg.user.hashedPassword != null)
      config.cfg.user.hashedPassword;

    hashedPasswordFile = lib.mkIf (config.cfg.user.sops.hashedPasswordKey != null)
      config.sops.secrets.userPasswordHash.path;

    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
      "dialout"
    ];
  };
}
