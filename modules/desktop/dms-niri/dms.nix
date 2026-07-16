{ pkgs, dms-plugin-registry, ... }:

{
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
    };
    
    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableClipboardPaste = false;      # Pasting from the clipboard history (wtype)

    plugins = {
      dankBatteryAlerts.enable = true;
      dankBatteryAlerts.src = dms-plugin-registry.packages.${pkgs.system}.dankBatteryAlerts;
    };
  };

}
