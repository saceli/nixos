{ config, pkgs, ... }:

{
  users.users.elia.packages = [ pkgs.eog ];
}
