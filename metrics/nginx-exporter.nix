{ ... }:
{
  services.nginx.statusPage = true;

  services.prometheus.exporters.nginx.enable = true;
  services.prometheus.exporters.nginx.listenAddress = "127.0.0.1";
}
