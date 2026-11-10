{ config, lib, ... }:

{
  environment.etc."git/allowed_signers".text =
    (lib.concatStringsSep "\n" config.cfg.git.allowedSigners) + "\n";

  programs.git.config = {
    user.name = config.cfg.git.userName;
    user.email = config.cfg.git.userEmail;
    user.signingKey = config.cfg.git.signingKey;
    gpg.format = config.cfg.git.gpgFormat;
    commit.gpgSign = config.cfg.git.signCommits;
    gpg.ssh.allowedSignersFile = "/etc/git/allowed_signers";
    init.defaultBranch = config.cfg.git.defaultBranch;
  };
}
