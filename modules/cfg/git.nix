{ lib, ... }:

{
  options.cfg.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      default = "saceli";
      description = "Git user name (git user.name).";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "301811192+saceli@users.noreply.github.com";
      description = ''
        Git user email (git user.email). A GitHub noreply address is used
        instead of a real email address.
      '';
    };

    signingKey = lib.mkOption {
      type = lib.types.str;
      default = "~/.ssh/github";
      description = "SSH key used to sign commits (git user.signingKey), also used as the identity file for the github.com SSH host alias.";
    };

    gpgFormat = lib.mkOption {
      type = lib.types.str;
      default = "ssh";
      description = "Signature format used for commit signing (git gpg.format).";
    };

    signCommits = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to sign commits by default (git commit.gpgSign).";
    };

    defaultBranch = lib.mkOption {
      type = lib.types.str;
      default = "main";
      description = "Default branch name for newly initialized repositories (git init.defaultBranch).";
    };

    allowedSigners = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = "";
      description = ''
        SSH public keys allowed to verify commit signatures
        (git gpg.ssh.allowedSignersFile), one key per line in allowed_signers
        format. Rendered to /etc/git/allowed_signers.
      '';
    };
  };
}
