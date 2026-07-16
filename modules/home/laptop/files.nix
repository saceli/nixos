{
  files = {
    
    # GTK
    ".config/gtk-3.0/settings.ini".source = ./configs/gtk/gtk-3.0/settings.ini;
    ".config/gtk-4.0/settings.ini".source = ./configs/gtk/gtk-4.0/settings.ini;

    # DankMaterialShell
    ".config/DankMaterialShell/settings.json".source =
      ./configs/DankMaterialShell/settings.json;

    ".local/state/DankMaterialShell/session.json".source =
      ./configs/DankMaterialShell/session.json;

    ".config/DankMaterialShell/clsettings.json".source = 
      ./configs/DankMaterialShell/clsettings.json; # disable clipboard history!!!!!!!!

    # dgop
    ".config/dgop/colors.json".source =
      ./configs/dgop/colors.json;

    # niri
    ".config/niri/config.kdl".source =
      ./configs/niri/config.kdl;
  };
}
