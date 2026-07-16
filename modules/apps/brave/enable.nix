{
  config,
  pkgs,
  ...
}:

{
  programs.chromium.enable = true;
  users.users."elia".packages = [ pkgs.brave ];
}
