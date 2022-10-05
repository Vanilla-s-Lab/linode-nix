{ pkgs, ... }:
{
  users.users."root" = {
    shell = pkgs.fish;

    hashedPassword = "$6" + "$NixOS/Linode" +
      "$9wP2TPxYcCHdt5gQL5UgGeBUWkdLRndxCQqHEnVS8xC5CiJhmZY0UA"
      + ".7hsaKWtOmaHnM1llFqqGOJrtj0hOCA/";
  };

  users.mutableUsers = false;
}
