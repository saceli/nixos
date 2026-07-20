{ config, lib, pkgs, ... }:

let
  username = "elia";
  avatarPath = ../../../assets/pfp/elia.png ; 
in {
  systemd.tmpfiles.rules = [
    # Create the user config file with the Icon directive
    "f+ /var/lib/AccountsService/users/${username}  0600 root root - [User]\nIcon=/var/lib/AccountsService/icons/${username}\n"
    # Symlink the icon image to the AccountsService icons directory
    "L+ /var/lib/AccountsService/icons/${username}  - - - - ${avatarPath}"
  ];
}   