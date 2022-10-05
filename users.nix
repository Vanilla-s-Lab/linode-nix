{ pkgs, ... }:
{
  users.users."root" = {
    shell = pkgs.fish;
  };

  users.mutableUsers = false;
}
