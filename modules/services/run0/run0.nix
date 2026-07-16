{ config, pkgs, ... }:

{
  # inverted background for run0
  users.users.elia.packages = [
    (pkgs.writeShellScriptBin "run0" ''
      /run/current-system/sw/bin/run0 --background="" "$@"
    '')
  ];

  # require password for members of wheel group
  security.run0.wheelNeedsPassword = true;

  # set a shell alias for sudo
  # do not replace the sudo package, for some reason... (i copy pasted this)
  environment.shellAliases.sudo = "run0";

  # NOTE: you cant make run0 persist for 5 minutes with AUTH_KEEP in polkit rules 
  #       for some reason i cant remember, if you can do it contact me i beg you

}
