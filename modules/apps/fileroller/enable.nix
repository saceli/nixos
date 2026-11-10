{ config, pkgs, ... }:

{
  users.users.${config.cfg.user.username}.packages = [ pkgs.file-roller ];
}
