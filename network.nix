{ ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  # TODO: Check the firewall of Linode, prefer.
  networking.firewall.logRefusedConnections = false;
}
