{ pkgs, dms-plugin-registry, ... }:

{
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dux.service when dux-shell changes
    };

/*
    plugins = {
      dankBatteryAlerts.enable = true;
      dankBatteryAlerts.src = dms-plugin-registry.packages.${pkgs.system}.dankBatteryAlerts;
    };
*/
  };

}
