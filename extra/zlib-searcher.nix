{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.wget
    pkgs.unzip
  ];

  # https://github.com/zlib-searcher/zlib-searcher/blob/master/docker-compose.yml
  virtualisation.oci-containers.containers."zlib-searcher" = {
    image = "ghcr.io/zlib-searcher/zlib-searcher:latest";
    ports = lib.singleton "127.0.0.1:7070:7070";
    volumes = lib.singleton "/root/index:/index";
  };
}
