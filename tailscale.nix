{ lib, config, ... }:
{
  services.tailscale.enable = true;
  services.tailscale.interfaceName = "tailscale";
  networking.firewall.allowedUDPPorts = lib.singleton
    config.services.tailscale.port;
}
