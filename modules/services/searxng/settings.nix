{
  config,
  lib,
  ...
}:

{
  hjem.users.elia.files = {
    # Rootless Quadlet - runs as user 'elia'
    ".config/containers/systemd/searxng.container".text = ''
      [Unit]
      Description=SearXNG
      After=network-online.target
      Wants=network-online.target

      [Container]
      Image=docker.io/searxng/searxng:latest
      PublishPort=127.0.0.1:8001:8080

      Environment=BASE_URL=http://search.home/
      Environment=INSTANCE_NAME=SearXNG

      # Security hardening
      ReadOnly=true
      DropCapability=ALL
      NoNewPrivileges=true
      SecurityLabelDisable=false

      # Writable tmpfs for runtime files (searxng needs /tmp and /run)
      Tmpfs=/tmp:rw,size=100M
      Tmpfs=/run/searxng:rw,size=10M,mode=755

      # Mount settings directory so you can drop in a custom settings.yml
      Volume=%h/.local/share/searxng:/etc/searxng:Z

      # Load the secret from a file NOT in the Nix store
      EnvironmentFile=%h/root/searxng.env

      HealthCmd=wget --spider -q http://localhost:8080/healthz
      HealthInterval=30s
      HealthTimeout=5s
      HealthRetries=3
      HealthStartPeriod=10s

      AutoUpdate=registry

      [Service]
      Restart=always
      RestartSec=5
      # Ensure Podman pulls before starting
      ExecStartPre=-/usr/bin/podman pull docker.io/searxng/searxng:latest

      [Install]
      WantedBy=default.target
    '';
  };
}
