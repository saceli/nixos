{ lib, ... }:

{
  options.cfg.localization = {
    keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "it";
      description = "X11 keyboard layout (services.xserver.xkb.layout).";
    };

    keyboardVariant = lib.mkOption {
      type = lib.types.str;
      default = "winkeys";
      description = "X11 keyboard variant (services.xserver.xkb.variant).";
    };

    consoleKeyMap = lib.mkOption {
      type = lib.types.str;
      default = "it";
      description = "Console keymap, also assignable temporarily with `loadkeys <value>` (console.keyMap).";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "it_IT.UTF-8";
      description = "Locale used for every LC_* setting in i18n.extraLocaleSettings.";
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Rome";
      description = "System time zone (time.timeZone).";
    };
  };
}
