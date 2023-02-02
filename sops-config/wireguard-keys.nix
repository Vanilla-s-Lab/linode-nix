{ config, ... }:
{
  sops.secrets."wireguard-keys/private".sopsFile =
    ../secrets/wireguard-keys.yaml;
}
