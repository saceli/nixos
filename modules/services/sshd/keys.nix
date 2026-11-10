{ config, ... }:

{

  users.users.${config.cfg.user.username}.openssh.authorizedKeys.keys = config.cfg.ssh.authorizedKeys;

}
