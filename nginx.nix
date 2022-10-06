{ pkgs, ... }:
{
  services.nginx.enable = true;

  # https://nixos.wiki/wiki/Nginx
  services.nginx.virtualHosts."vanilla.scp.link" = {
    addSSL = true;
    enableACME = true;
    root = "${pkgs.nginx}/html";
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "osu_Vanilla@126.com";

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
