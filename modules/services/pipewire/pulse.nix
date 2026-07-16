{ config, pkgs, ... }:

{
  # disable pulseaudio
  services.pulseaudio.enable = false;

  # pulseaudio backend for pipewire
  services.pipewire.pulse.enable = true;

  # pavucontrol
  users.users.elia.packages = [ pkgs.pavucontrol ];
}
