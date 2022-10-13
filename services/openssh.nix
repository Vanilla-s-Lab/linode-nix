{ lib, pkgs, ... }:
{
  services.openssh.enable = true;

  # services.openssh.permitRootLogin = lib.mkForce "yes";
  # services.openssh.passwordAuthentication = true;

  # https://nmap.org/nsedoc/scripts/ssh-auth-methods.html
  environment.systemPackages = [
    pkgs.nmap
  ];

  services.openssh.kbdInteractiveAuthentication = false;

  users.users."root".openssh.authorizedKeys.keyFiles = lib.singleton (pkgs.fetchurl {
    url = "https://github.com/VergeDX.keys"; # Yubikeys 5 NFC
    hash = "sha256-ASglsi7Ape5I9MabvIiWXPI7IeumBaoVTb+pX3Hm5EA=";
  });
}
