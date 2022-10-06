{ config, lib, pkgs, ... }:
{
  services.headscale.enable = true;

  services.headscale.address = "0.0.0.0";
  # services.headscale.port = 443;

  networking.firewall.allowedTCPPorts =
    lib.singleton config.services.headscale.port;

  services.headscale.serverUrl = "http://vanilla.scp.link:8080";

  environment.systemPackages = [
    config.services.headscale.package
  ] ++ [ pkgs.htop pkgs.ripgrep ];

  # https://github.com/juanfont/headscale/blob/main/config-example.yaml
  services.headscale.settings = {
    ip_prefixes = [
      "fd7a:115c:a1e0::/48"
      "100.64.0.0/10"
    ];
  };
}
