{ config, pkgs, ... }:

{
  # inverted background for run0
  users.users.${config.cfg.user.username}.packages = [
    (pkgs.writeShellScriptBin "run0" ''
      /run/current-system/sw/bin/run0 --background="" "$@"
    '')
  ];

  # require password for members of wheel group
  security.run0.wheelNeedsPassword = true;

  # set a shell alias for sudo
  environment.shellAliases.sudo = "run0";

  # NOTE: if you use run0 with a password, the password cant persist for 5 minutes with AUTH_KEEP in polkit rules
  #       for some reason i cant remember, if you can do it contact me i beg you :D

}
