{ config, ... }:

{
  # keyboard layout
  services.xserver.xkb = {
    layout = "it";
    variant = "winkeys";
  };

  # tty keyboard layout (you can also assign it temporarily with `loadkeys [value]` )
  console.keyMap = "it";
}
