{
  # enable pipewire
  services.pipewire.enable = true;

  services.pipewire.extraConfig.pipewire = { # without this the audio sounds drunk or with autotune, for some reason...
    "91-audio-rates" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 48000 ];
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 8192;
        "default.clock.quantum" = 1024;
      };
    };
  };
}
