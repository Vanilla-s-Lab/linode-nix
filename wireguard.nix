{ pkgs, ... }:
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
        {
          publicKey = "A5Acrw7cwNBcw1h5/L/qKmaSPknGqwFMZAMyjcp4TyA=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
