{ pkgs, ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  # https://serverfault.com/questions/1029041/how-to-create-dummy-interface-in-etc-systemd-network

  systemd.network.enable = true;

  systemd.network.netdevs."bgp" = {
    netdevConfig = {
      Name = "bgp";
      Kind = "dummy";
    };
  };

  systemd.network.networks."bgp" = {
    matchConfig = {
      Name = "bgp";
    };

    address = [
      "172.22.130.97"
      "fd13:f622:f715::1"
    ];
  };
}
