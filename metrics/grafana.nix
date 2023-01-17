{ ... }:
{
  services.grafana.enable = true;
  services.grafana.settings = rec {
    server.http_addr = "127.0.0.1";

    server.domain = "grafana.vergedx.me";
    server.root_url = "https://${server.domain}/";
  };

  services.nginx.upstreams."grafana".servers = {
    "127.0.0.1:3000" = { };
  };

  services.nginx.virtualHosts = {
    "grafana.vergedx.me" = {
      addSSL = true;
      enableACME = true;

      # https://grafana.com/tutorials/run-grafana-behind-a-proxy/
      # https://github.com/yandex/gixy/blob/master/docs/en/plugins/hostspoofing.md

      locations."/".extraConfig = ''
        proxy_set_header Host $host;
        proxy_pass http://grafana;
      '';

      locations."/api/live/".extraConfig = ''
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $host;
        proxy_pass http://grafana;
      '';
    };
  };
}
