{ pkgs, lib, ... }:
{
  users.users."vanilla" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    shell = pkgs.fish;

    hashedPassword = "$6" + "$NixOS/Linode" +
      "$9wP2TPxYcCHdt5gQL5UgGeBUWkdLRndxCQqHEnVS8xC5CiJhmZY0UA"
      + ".7hsaKWtOmaHnM1llFqqGOJrtj0hOCA/";

    openssh.authorizedKeys.keyFiles = lib.singleton (pkgs.fetchurl {
      url = "https://github.com/VergeDX.keys"; # Yubikeys 5 NFC
      hash = "sha256-ASglsi7Ape5I9MabvIiWXPI7IeumBaoVTb+pX3Hm5EA=";
    });
  };

  users.mutableUsers = false;
}
