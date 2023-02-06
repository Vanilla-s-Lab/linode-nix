{ pkgs, ... }:
{
  services.pykms.enable = true;
  services.pykms.openFirewallPort = true;

  services.nginx.virtualHosts = {
    "pykms.vergedx.me" = {
      addSSL = true;
      enableACME = true;

      # https://nixos.wiki/wiki/Nginx
      root = "${pkgs.nginx}/html";
    };
  };
}
