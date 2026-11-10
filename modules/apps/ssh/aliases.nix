{ pkgs, config, ... }:

let
  globalPiSettings = ''
    HostName ${config.cfg.homelab.privateIp}
    User ${config.cfg.user.username}
    Port 22
    SetEnv TERM=xterm-256color
    IdentityFile ${config.cfg.ssh.raspiIdentityFile}
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
        IdentityFile ${config.cfg.git.signingKey}
    '';
  };
}
