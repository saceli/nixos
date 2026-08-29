{
  files = {

    # Bash profile
    ".profile".source = ./configs/bash/.profile;
    
    # GTK
    ".config/gtk-3.0/settings.ini".source = ../laptop/configs/gtk/gtk-3.0/settings.ini;
    ".config/gtk-4.0/settings.ini".source = ../laptop/configs/gtk/gtk-4.0/settings.ini;

    # DankMaterialShell
    ".config/DankMaterialShell/settings.json".source =
      ../laptop/configs/DankMaterialShell/settings.json;

    ".local/state/DankMaterialShell/session.json".source =
      ./configs/DankMaterialShell/session.json;

    ".config/DankMaterialShell/clsettings.json".source = 
      ../laptop/configs/DankMaterialShell/clsettings.json # disable clipboard history!!!!!!!!

    # dgop
    ".config/dgop/colors.json".source =
      ../laptop/configs/dgop/colors.json;

    # niri
    ".config/niri/config.kdl".source =
      ../laptop/configs/niri/config.kdl;
  };
}
