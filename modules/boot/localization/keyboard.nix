{ config, ... }:

{
  # keyboard layout
  services.xserver.xkb = {
    layout = config.cfg.localization.keyboardLayout;
    variant = config.cfg.localization.keyboardVariant;
  };

  # tty keyboard layout (you can also assign it temporarily with `loadkeys [value]` )
  console.keyMap = config.cfg.localization.consoleKeyMap;
}
