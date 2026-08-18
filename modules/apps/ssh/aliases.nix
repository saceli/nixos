{ pkgs, config, ... }:

let
  globalPiSettings = ''
    HostName 192.168.178.33
    User elia
    Port 22
    SetEnv TERM=xterm-256color
    IdentityFile ~/.ssh/raspi
  '';
in 


{
  programs.ssh = {
    extraConfig = ''
      Host pi
        ${globalPiSettings}

      Host homelab
        ${globalPiSettings}

      Host raspi
        ${globalPiSettings}

      Host nixodactyl
        ${globalPiSettings}

      Host github
        HostName github.com
        User git
        IdentityFile ~/.ssh/github
    '';
  };
}
