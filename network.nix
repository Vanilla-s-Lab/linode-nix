{ ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  # TODO: Check the firewall of Linode, prefer.
  networking.firewall.logRefusedConnections = false;

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.firewall.trustedInterfaces = [
    "wg0"
  ];
}
