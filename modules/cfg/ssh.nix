{ lib, ... }:

{
  options.cfg.ssh = {
    raspiIdentityFile = lib.mkOption {
      type = lib.types.str;
      default = "~/.ssh/raspi";
      description = "SSH identity file used for the raspi/homelab/pi/nixodactyl host aliases.";
    };

    authorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = "";
      description = "SSH public keys authorized for the main user, declared directly (users.<username>.openssh.authorizedKeys.keys).";
    };
  };
}
