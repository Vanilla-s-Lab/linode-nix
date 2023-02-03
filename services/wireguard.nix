{ lib, pkgs, ... }:
{
  # https://dn42.dev/howto/nixos
  networking.wireguard.interfaces."wg" = {

    # privateKey = "";
    privateKeyFile = "/run/secrets/wireguard-keys/private";

    allowedIPsAsRoutes = false;
    listenPort = 22688;

    peers = lib.singleton {
      publicKey = "vfrrbtKAO5438daHrTD0SSS8V6yk78S/XW7DeFrYLXA=";
      allowedIPs = [ "0.0.0.0/0" "::/0" ];
      endpoint = "las1.us.dn42.miaotony.xyz:21317";
    };

    # `ping fe80::2688%dn42-peer`
    ips = lib.singleton "fe80::1317/64";
  };
}
