{ config, pkgs, ... }:

{
  users.users.elia.packages = [ pkgs.zathura ];
}
