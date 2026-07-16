{ pkgs, ... }:

let
  host = pkgs.stdenv.hostPlatform.system;

  all = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  emulated = builtins.filter (s: s != host) all;
in
{
  # allow emulating the aarch64-linux, x86_64-linux architectures
  # (especially if you wanna build a raspi-sd-image)
  boot.binfmt.emulatedSystems = emulated;
}
