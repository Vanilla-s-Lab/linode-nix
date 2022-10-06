{ config, ... }:
{
  # https://nixos.wiki/wiki/FAQ/How_can_I_install_a_proprietary_or_unfree_package%3F
  nixpkgs.config.allowUnfree = true;

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [
    config.services.zerotierone.port
  ];
}
