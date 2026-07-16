{ pkgs, ... }:

{

  programs.xwayland.enable = true;
  virtualisation.vmware.guest.enable = true;
  virtualisation.vmware.host.enable = true;

  # idk if i need these, but ill keep them ig.
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;
}