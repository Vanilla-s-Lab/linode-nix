{ lib, pkgs, ... }:
{
  # https://dn42.dev/howto/nixos
  networking.wireguard.interfaces."dn42-peer" = {

    # privateKey = "";
    privateKeyFile = "/run/secrets/wireguard-keys/private";

    allowedIPsAsRoutes = false;
    listenPort = 22688;

    peers = lib.singleton {
      publicKey = "vfrrbtKAO5438daHrTD0SSS8V6yk78S/XW7DeFrYLXA=";
      allowedIPs = [ "0.0.0.0/0" "::/0" ];
      endpoint = "las1.us.dn42.miaotony.xyz:21317";
    };

    # dig las1.us.dn42.miaotony.xyz TXT +short | sed 's/[" ]//g' | base64 -d

    postSetup = ''
      ${pkgs.iproute}/bin/ip addr add 172.22.130.97/32 peer 172.23.6.6/32 dev dn42-peer
      ${pkgs.iproute}/bin/ip -6 addr add fd13:f622:f715::/128 peer fd00:feed:ca7::6/128 dev dn42-peer
    '';
  };
}
