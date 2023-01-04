{ ... }:
{
  services.prometheus.exporters.node.enable = true;
  services.prometheus.exporters.node.listenAddress = "127.0.0.1";

  # https://grafana.com/grafana/dashboards/1860-node-exporter-full/
  services.prometheus.exporters.node.enabledCollectors = [ "systemd" "processes" ];
}
