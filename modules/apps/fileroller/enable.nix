{ config, pkgs, ... }:

{
  users.users.elia.packages = [ pkgs.file-roller ];
}
