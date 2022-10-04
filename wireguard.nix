{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wireguard-tools
  ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;

      # https://nixos.wiki/wiki/WireGuard
      privateKeyFile = "/root/wireguard-keys/private";
    };
  };
}
