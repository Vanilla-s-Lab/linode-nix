{ ... }:
{
  services.grafana.enable = true;
  services.grafana.settings = {
    server.http_addr = "127.0.0.1";

    server.domain = "grafana.vergedx.me";
  };

  services.nginx.virtualHosts = {
    "grafana.vergedx.me" = {
      addSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";

        # https://grafana.com/tutorials/run-grafana-behind-a-proxy/
        # https://github.com/yandex/gixy/blob/master/docs/en/plugins/hostspoofing.md
        extraConfig = "proxy_set_header Host" + " " + /* "$http_host" */ "$host" + ";";
      };
    };
  };
}
