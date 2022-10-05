{ ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.firewall.trustedInterfaces = [
    "wg0"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
}
