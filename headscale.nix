{ config, lib, ... }:
{
  services.headscale.enable = true;

  services.headscale.address = "0.0.0.0";
  services.headscale.port = 443;

  networking.firewall.allowedTCPPorts = [ 80 ]
    ++ lib.singleton config.services.headscale.port;

  services.headscale.tls.letsencrypt.hostname = "vanilla.scp.link";
  services.headscale.serverUrl = "https://vanilla.scp.link:443";

  environment.systemPackages = [
    config.services.headscale.package
  ];

  networking.firewall.checkReversePath = "loose";
}
