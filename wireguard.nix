{ pkgs, ... }:
let mkPeers = name: pk: ips: { publicKey = pk; allowedIPs = ips; }; in
{
  environment.systemPackages = [
    pkgs.wireguard-tools
    pkgs.python3 # http.server
  ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;

      # https://nixos.wiki/wiki/WireGuard
      privateKeyFile = "/root/wireguard-keys/private";

      peers = [
        (mkPeers "NixOS-RoT" "A5Acrw7cwNBcw1h5/L/qKmaSPknGqwFMZAMyjcp4TyA=" [ "10.100.0.2/32" ])

        # (mkPeers "Redmi-K30" "PSZJtkR1gUBUIw/SNRSAz3K/4BZCnoxJ8U2A757sAj4=" [ "10.100.0.3/32" ])
        # (mkPeers "Xiaomi-Pad-5" "U22iFFBctYIEzhAawMTCvWztqPI3gkYJdpkWni/nOQ0=" [ "10.100.0.4/32" ])

        # (mkPeers "Caetrix" "JDr3xRNUeBOtBqvdkluQtF8i1laHnLgrc5Afto1uIhs=" [ "10.100.0.5/32" ])
        (mkPeers "Caetrix" "cr5ee8qicx4nxZThmsP9BYVhyM9a1Ovms4zvhZgKSTc=" [ "10.100.0.5/32" ])
        # (mkPeers "Reliena" "HYoNq/B7/uC/d7yCD0N8o1IIZOOKLceHxTd61m3ksQQ=" [ "10.100.0.6/32" ])

        # (mkPeers "Win11" "cI/NKRGnsC2+8oQYP2fD8Y38XbjAiS3gHLRRL/zfs0w=" [ "10.100.0.7/32" ])
      ];
    };
  };
}
