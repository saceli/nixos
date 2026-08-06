{ config, quadlet-nix, ... }:

let
  user = "elia";
  home = "/home/${user}";
  searxngDir = "${home}/.local/share/searxng";
in
{
  # Rootless requirements
  users.users.${user} = {
    linger = true;                # keep user systemd around after logout
    autoSubUidGidRange = true;    # allocate /etc/subuid + /etc/subgid
  };

  virtualisation.quadlet.containers.searxng = {
    autoStart = true;

    # Run this container as user 'elia' via systemd User=...
    rootlessConfig.uid = config.users.users.${user}.uid;

    unitConfig = {
      Description = "SearXNG (rootless)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    containerConfig = {
      image = "docker.io/searxng/searxng:latest";
      publishPorts = [ "127.0.0.1:8001:8080" ];

      environments = {
        INSTANCE_NAME = "SearXNG";
	GRANIAN_HOST = "0.0.0.0";
      };

      readOnly = true;
      dropCapabilities = [ "ALL" ];
      noNewPrivileges = true;

      tmpfses = [
        "/tmp:rw,size=100M"
        "/run/searxng:rw,size=10M,mode=755"
      ];

      volumes = [
        "${searxngDir}:/etc/searxng:Z"
      ];

      healthCmd = "wget --spider -q http://localhost:8080/healthz";
      healthInterval = "30s";
      healthTimeout = "5s";
      healthRetries = 3;
      healthStartPeriod = "10s";

      autoUpdate = "registry";
    };

    serviceConfig = {
      Restart = "always";
      RestartSec = "5";
    };
  };

}
