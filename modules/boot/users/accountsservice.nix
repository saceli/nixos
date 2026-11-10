{
  config,
  lib,
  pkgs,
  ...
}:

let
  username = config.cfg.user.username;
  avatar = config.cfg.user.avatar;
in
{
  config = lib.mkIf (avatar != null) {
    systemd.tmpfiles.rules = [
      # Create the user config file with the Icon directive
      "f+ /var/lib/AccountsService/users/${username}  0644 root root - [User]\nIcon=/var/lib/AccountsService/icons/${username}\n"
      # Symlink the icon image to the AccountsService icons directory
      "L+ /var/lib/AccountsService/icons/${username}  - - - - ${avatar}"
    ];
  };
}
