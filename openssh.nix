{ lib, pkgs, ... }:
rec {
  services.openssh.enable = true;
  # TODO: Disable all methods except pubkey.
  # services.openssh.permitRootLogin = "no";

  users.users."vanilla".openssh.authorizedKeys.keyFiles = lib.singleton (pkgs.fetchurl {
    url = "https://github.com/VergeDX.keys"; # Yubikeys 5 NFC
    hash = "sha256-ASglsi7Ape5I9MabvIiWXPI7IeumBaoVTb+pX3Hm5EA=";
  });

  users.users."root".openssh.authorizedKeys.keyFiles =
    users.users."vanilla".openssh.authorizedKeys.keyFiles;
}
