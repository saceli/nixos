{ pkgs, ... }:

{
  users.users.elia.packages = [ pkgs.sops ];
}