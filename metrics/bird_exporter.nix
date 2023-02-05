{ ... }:
{
  # https://github.com/czerwonk/bird_exporter
  services.prometheus.exporters.bird.enable = true;
  services.prometheus.exporters.bird.listenAddress = "127.0.0.1";
}
