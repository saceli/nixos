{ pkgs, ... }:

{
  # idk if i need these so ill keep them ig ¯\_(ツ)_/¯
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;
}