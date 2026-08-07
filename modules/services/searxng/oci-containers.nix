{ config, pkgs, lib, ... }:

let
  settings = {
    use_default_settings = true;
    general = {
      debug = false;
      instance_name = "searxng";
      donation_url = false;
      contact_url = false;
      privacypolicy_url = false;
      enable_metrics = false;
    };
    ui = {
      static_use_hash = true;
      query_in_title = false;
      infinite_scroll = true;
      center_alignment = true;
      default_theme = "simple";
      theme_args = { simple_style = "dark"; };
      results_on_new_tab = false;
      search_on_category_select = false;
      url_formatting = "full";
      categories_as_tabs = [ "general" ];
      favicon_resolver = "https://icons.duckduckgo.com/ip3/{domain}.ico";
    };
    search = {
      safe_search = 0;
      autocomplete_min = 2;
      autocomplete = "duckduckgo";
    };
    server = {
      base_url = "https://search.home";
      public_instance = false;
      limiter = false;
      image_proxy = true;
      method = "GET";
      port = 8080;
      bind_address = "0.0.0.0";
    };
    outgoing = {
      request_timeout = 60;
      max_request_timeout = 60;
    };
    enabled_plugins = [
      "Basic Calculator"
      "Hash plugin"
      "Tor check plugin"
      "Open Access DOI rewrite"
      "Hostnames plugin"
      "Unit converter plugin"
      "Tracker URL remover"
    ];
    engines = config.searxng.engines or [];
  };

  settingsFile = pkgs.writeText "searxng-settings.yml" (builtins.toJSON settings);

in
{
  imports = [ ./engines.nix ];

  virtualisation.containers.enable = true;
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers.searxng = {
    image = "docker.io/searxng/searxng:latest";
    autoStart = true;
    ports = [ "0.0.0.0:8080:8080" ];
    volumes = [
      "${settingsFile}:/etc/searxng/settings.yml:ro"
    ];
    environment = {
      INSTANCE_NAME = "SearXNG";
    };
    extraOptions = [
      "--read-only"
      "--cap-drop=ALL"
      "--no-new-privileges"
      "--tmpfs=/tmp:rw,size=100M"
      "--tmpfs=/run/searxng:rw,size=10M,mode=755"
      "--health-cmd=wget --spider -q http://localhost:8080/healthz || exit 1"
      "--health-interval=30s"
      "--health-timeout=5s"
      "--health-retries=3"
      "--health-start-period=10s"
    ];
  };

  systemd.services."podman-searxng" = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };
}
