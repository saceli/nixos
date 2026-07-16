{
  # settings for the nix package manager
  nix.settings = {

    # enable experimental features
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # only allow members of the wheel group
    # to use the nix package manager
    allowed-users = [ "@wheel" ];

    # only trust the root user
    trusted-users = [ "root" ];

    # download only cryptographically signed binaries
    # preventing MITM attacks
    require-sigs = true;

    # deny IFDs which slow down evaluation
    allow-import-from-derivation = true;

    # deny flake-config which can inject
    # unsafe configurations into nix
    accept-flake-config = false;

    # do not warn about dirty git trees
    warn-dirty = false;

    # enable automatic deduplication
    auto-optimise-store = true;

  };

  # do not automatically run gc
  nix.gc.automatic = false; 
  # for servers use:
  #nix.gc = {
	#  automatic = true;
	#  dates = "weekly"; # Runs once a week (e.g., "Mon *-*-* 02:00" for 2 AM Monday)
	#  options = "--delete-older-than 15d"; # Deletes packages and generations older than 15 days
	#  persistent = true; # Ensures GC runs later if the server is powered down during the scheduled time
	#};

}
