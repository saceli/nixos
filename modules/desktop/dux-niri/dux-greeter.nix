{ config, pkgs, ... }:

{
  services.displayManager.dms-greeter.enable = true;
  services.displayManager.dms-greeter.compositor.name = "niri";
  services.displayManager.dms-greeter.configHome = "/home/${config.cfg.user.username}";
}
