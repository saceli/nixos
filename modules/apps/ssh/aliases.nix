{ pkgs, config, ... }:

{
  programs.ssh = {
    extraConfig = ''
    Host pi
      HostName 192.168.178.33
      User elia
      Port 22
      IdentityFile ~/.ssh/raspi

    Host homelab
      HostName 192.168.178.33
      User elia
      Port 22
      IdentityFile ~/.ssh/raspi

    Host raspi
      HostName 192.168.178.33
      User elia
      Port 22
      IdentityFile ~/.ssh/raspi

    Host nixodactyl
      HostName 192.168.178.33
      User elia
      Port 22
      IdentityFile ~/.ssh/raspi
    Host github
      HostName github.com
      User git
      IdentityFile ~/.ssh/github
  '';
  };
}
