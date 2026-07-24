{ config, ... }:

{
  programs.git.config = {
    user.name = "saceli";

    # Don't push your actual e-mail, it's a little bit unsafe, Better safe than sorry!
    # https://docs.github.com/en/account-and-profile/reference/email-addresses-reference#your-noreply-email-address
    user.email = "301811192+saceli@users.noreply.github.com"; 
    
    user.signingKey = "~/.ssh/github";
    gpg.format = "ssh";
    commit.gpgSign = true;
    gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    init.defaultBranch = "main";
  };
}
