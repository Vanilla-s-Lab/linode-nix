{ pkgs, ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

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

  # https://nixos.wiki/wiki/Encrypted_DNS
  networking.dhcpcd.enable = true;
  networking.dhcpcd.extraConfig =
    "nohook resolv.conf";

  environment.systemPackages = [
    pkgs.iperf3
    pkgs.speedtest-cli
    pkgs.tcpdump

    pkgs.wget
    pkgs.unzip
    pkgs.python3
  ];
}
