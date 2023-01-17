{ lib, pkgs, ... }: {
  environment.systemPackages =
    lib.singleton pkgs.HentaiAtHome;

  systemd.services."HAH" = {
    enable = true;

    # https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/
    after = lib.singleton "network-online.target";
    wants = lib.singleton "network-online.target";

    serviceConfig = {
      "ExecStart" = "${pkgs.HentaiAtHome}/bin/HentaiAtHome";
      "WorkingDirectory" = "/root"; # Credential: data/client_login

      "Restart" = "always";
      "Type" = "simple";
    };
  };

  # https://www.reddit.com/r/NixOS/comments/rezf0s/how_to_run_script_on_startup/
  systemd.services."HAH".wantedBy = lib.singleton "multi-user.target";

  networking.firewall.allowedTCPPorts = lib.singleton 33279;
  # networking.firewall.allowedUDPPorts = lib.singleton 33279;
}
