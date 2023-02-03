{ lib, pkgs, ... }:
{
  services.openssh.enable = true;

  # https://nixos.wiki/wiki/SSH_public_key_authentication
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  users.users."root".openssh.authorizedKeys.keyFiles = lib.singleton (pkgs.fetchurl {
    url = "https://github.com/VergeDX.keys"; # Yubikeys 5 NFC
    hash = "sha256-ASglsi7Ape5I9MabvIiWXPI7IeumBaoVTb+pX3Hm5EA=";
  });
}
