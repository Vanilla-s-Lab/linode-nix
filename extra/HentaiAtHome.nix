{ lib, pkgs, ... }: {
  environment.systemPackages =
    lib.singleton pkgs.HentaiAtHome;

  systemd.services."HAH" = {
    enable = true;

    # https://mysystemd.talos.sh/
    after = lib.singleton "network.target";
    wants = lib.singleton "network-online.target";

    serviceConfig = {
      "ExecStart" = "${pkgs.HentaiAtHome}/bin/HentaiAtHome";
      "WorkingDirectory" = "/root"; # Credential: data/client_login
    };
  };

  # https://www.reddit.com/r/NixOS/comments/rezf0s/how_to_run_script_on_startup/
  systemd.services."HAH".wantedBy = lib.singleton "multi-user.target";

  networking.firewall.allowedTCPPorts = lib.singleton 443;
  networking.firewall.allowedUDPPorts = lib.singleton 443;
}