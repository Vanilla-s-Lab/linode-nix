{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.wget
    pkgs.unzip
  ];

  # https://github.com/orgs/Vanilla-s-Lab/packages?repo_name=collections
  virtualisation.oci-containers.containers."book-searcher" = {
    image = "ghcr.io/vanilla-s-lab/book-searcher:0.8.2";
    ports = lib.singleton "127.0.0.1:7070:7070";
  };
}
