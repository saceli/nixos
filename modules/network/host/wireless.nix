{ config, ... }:

{
  users.users.${config.cfg.user.username}.extraGroups = [
    "networkmanager"
  ];
}
