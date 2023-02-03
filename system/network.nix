{ pkgs, ... }:
{
  networking.hostName = "NixOS-Linode";
  networking.firewall.allowPing = false;

  # https://serverfault.com/questions/1029041/how-to-create-dummy-interface-in-etc-systemd-network

  systemd.network.enable = true;

  systemd.network.netdevs."dummy" = {
    netdevConfig = { Name = "dummy"; Kind = "dummy"; };
  };

  systemd.network.networks."dummy" = {
    matchConfig = { Name = "dummy"; };

    address = [
      "172.22.130.97"
      "fd13:f622:f715::1"
    ];
  };
}
