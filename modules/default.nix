{


    apps = {
      bash = { imports = [ ./apps/bash ]; };
      brave = { imports = [ ./apps/brave ]; };
      git = { imports = [ ./apps/git ]; };
      zathura = { imports = [ ./apps/zathura ]; };

    };

    boot = {
      emulated = { imports = [ ./boot/emulated ]; };
      kernel = { imports = [ ./boot/kernel ]; };
      localization = { imports = [ ./boot/localization ]; };
      malloc = { imports = [ ./boot/malloc ]; };
      secureboot = { imports = [ ./boot/secureboot ]; };
      systemd-boot = { imports = [ ./boot/systemd-boot ]; };
      uboot = { imports = [ ./boot/uboot ]; };
      users = { imports = [ ./boot/users ]; };

    };

    core = {
      nix = { imports = [ ./core/nix ]; };
      packages = { imports = [ ./core/packages ]; };
      state = { imports = [ ./core/state ]; };

    };

    desktop = {
      dms-niri = { imports = [ ./desktop/dms-niri ]; };
      niri = { imports = [ ./desktop/niri ]; };

    };
    hardware = { imports = [ ./hardware ]; };

    home = {
      laptop = { imports = [ ./home/laptop ]; };
      laptop-iso = { imports = [ ./home/laptop-iso ]; };
      raspi = { imports = [ ./home/raspi ]; };
      universal-configs = { imports = [ ./home/universal-configs ]; };

    };

    network = {
      firewall = { imports = [ ./network/firewall ]; };
      host = { imports = [ ./network/host ]; };
      macchanger = { imports = [ ./network/macchanger ]; };
      networkmanager = { imports = [ ./network/networkmanager ]; };

    };

    services = {
      auditd = { imports = [ ./services/auditd ]; };
      bluetooth = { imports = [ ./services/bluetooth ]; };
      journald = { imports = [ ./services/journald ]; };
      pipewire = { imports = [ ./services/pipewire ]; };
      run0 = { imports = [ ./services/run0 ]; };
      sshd = { imports = [ ./services/sshd ]; };
      timesyncd = { imports = [ ./services/timesyncd ]; };
      upower = { imports = [ ./services/upower ]; };

    };

}
