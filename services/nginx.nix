{ pkgs, ... }:
{
  services.nginx.enable = true;

  # https://xeiaso.net/blog/nixos-nginx-openssl-1.x
  services.nginx.package = pkgs.nginx.override { openssl = pkgs.openssl; };

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
