{
  imports = [
    ./accountsservice.nix
    ./disable-coredumps.nix
    ./disable-emergency.nix
    ./disable-rescue.nix
    ./immutable.nix
    ./lock-root.nix
    ./main.nix
    ./xdg.nix
  ];
}
