{ pkgs, ... }:

{
  users.users.elia.packages = [ pkgs.openssh ];
}
