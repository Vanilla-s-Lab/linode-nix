{ ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."vanilla.scp.link" = {
    addSSL = true;
    enableACME = true;
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "osu_Vanilla@126.com";

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
