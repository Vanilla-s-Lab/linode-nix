{ config, ... }:
{
  sops.secrets."csgo_exporter/STEAM_API_KEY".sopsFile =
    ../secrets/csgo_exporter.yaml;

  sops.templates."csgo_exporter".content = ''
    STEAM_API_KEY=${config.sops.placeholder."csgo_exporter/STEAM_API_KEY"}
  '';
}
