{


    hardware = {
      laptop = { imports = [ ./hardware/laptop ]; };
      live-cd = { imports = [ ./hardware/live-cd ]; };
      raspi = { imports = [ ./hardware/raspi ]; };

    };

    software = {
      laptop = { imports = [ ./software/laptop ]; };
      live-cd = { imports = [ ./software/live-cd ]; };
      raspi = { imports = [ ./software/raspi ]; };

    };

}
