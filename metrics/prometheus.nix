{ pkgs, lib, ... }:
let
  web-config = pkgs.writeTextFile {

    name = "web-config.yml";
    text = lib.generators.toYAML { } {
      basic_auth_users = {

        vanilla = "$2y$10$5APAJyhf4/20kQgT1rM7Xeag4/fZo5qG6.3WaOMSFXsR5PZlnNTLW";
        grafana = "$2y$10$2yceafrMbtVhTs3GQ81b..VKDEyPbcAd5hmBUOh0WoFHjEocDeo4e";
      };
    };
  };
in
{
  services.prometheus.enable = true;
  services.prometheus.listenAddress = "127.0.0.1";

  # Fix: Grafana Prometheus $__rate_interval defaults.
  services.prometheus.globalConfig.scrape_interval = "15s";

  # https://prometheus.io/docs/prometheus/latest/configuration/https/
  services.prometheus.extraFlags = [ "--web.config.file=${web-config}" ];

  services.nginx.virtualHosts = {
    "prometheus.vergedx.me" = {
      addSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:9090";
      };
    };
  };

  services.prometheus.scrapeConfigs = [{
    job_name = "localhost";
    static_configs = [{
      targets = [
        "127.0.0.1:9100"
        "127.0.0.1:9113"
      ];
    }];
  }];
}
