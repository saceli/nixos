{


    hardware = {
      laptop = { imports = [ ./hardware/laptop ]; };
      laptop-iso = { imports = [ ./hardware/laptop-iso ]; };
      raspi = { imports = [ ./hardware/raspi ]; };

    };

    software = {
      laptop = { imports = [ ./software/laptop ]; };
      laptop-iso = { imports = [ ./software/laptop-iso ]; };
      raspi = { imports = [ ./software/raspi ]; };

    };

}
