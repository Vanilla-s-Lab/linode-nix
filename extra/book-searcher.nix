{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.wget
    pkgs.unzip
  ];

  # https://github.com/zlib-searcher/zlib-searcher/blob/master/docker-compose.yml
  virtualisation.oci-containers.containers."book-searcher" = {
    image = "ghcr.io/book-searcher-org/book-searcher:0.8.0";
    ports = lib.singleton "127.0.0.1:7070:7070";
    volumes = lib.singleton "/root/index:/index";
  };
}
