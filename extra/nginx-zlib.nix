{ pkgs, ... }:
{
  services.nginx.enable = true;

  services.nginx.virtualHosts."zlib.vergedx.me" = {
    addSSL = true;
    enableACME = true;

    locations."/" = {
      proxyPass = "http://127.0.0.1:7070";
    };
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "osu_Vanilla@126.com";

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
}
