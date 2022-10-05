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

  # https://developers.google.com/speed/public-dns/docs/using
  # https://www.cloudflare.com/learning/dns/what-is-1.1.1.1/
  # https://en.wikipedia.org/wiki/1.1.1.1
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"

    "2001:4860:4860::8888"
    "2001:4860:4860::8844"

    "1.1.1.1"
    "1.0.0.1"

    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];
}
