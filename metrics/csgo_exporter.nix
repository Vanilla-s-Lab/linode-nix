{ pkgs, generated, config, ... }:
let
  pkgs_csgo_exporter =
    pkgs.callPackage
      ../pkgs/csgo_exporter.nix
      { inherit generated; };
in
{
  # https://github.com/NixOS/nixpkgs/blob/nixos-22.11/nixos/modules/services/monitoring/prometheus/exporters.nix

  systemd.services."csgo_exporter" = {
    enable = true;

    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      # https://serverfault.com/questions/867830/systemd-start-service-only-after-dns-is-available
      "ExecStartPre" = "${pkgs.bash}/bin/bash -c 'until ${pkgs.host}/bin/host api.steampowered.com; do sleep 1; done'";

      "ExecStart" = "${pkgs_csgo_exporter}/bin/csgo_exporter -steam_id 76561198319100373 -scrape_interval 16m";
      "Restart" = "always";

      # https://flatcar-linux.org/docs/latest/setup/systemd/environment-variables/
      "EnvironmentFile" = "${config.sops.templates."csgo_exporter".path}";
    };
  };
}
