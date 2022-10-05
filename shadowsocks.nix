{ pkgs, ... }:
{
  environment.systemPackages = [
    # https://github.com/Mic92/sops-nix
    pkgs.ssh-to-pgp
  ];
}
