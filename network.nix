{ ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  # TODO: Check the firewall of Linode, prefer.
  networking.firewall.logRefusedConnections = false;

  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
}
