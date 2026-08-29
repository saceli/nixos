{ pkgs, ... }:

{
  services.weechat.enable = true;

  environment.systemPackages = [
    pkgs.weechat
  ];
}
