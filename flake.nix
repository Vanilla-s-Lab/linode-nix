{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, deploy-rs, ... }:

    let system = "x86_64-linux"; in
    let pkgs = nixpkgs.legacyPackages.${system}; in

    rec {
      linode = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          { system.stateVersion = "22.11"; }

          ./system/users.nix
          ./system/network.nix

          "${nixpkgs}/nixos/modules/virtualisation/linode-config.nix"
          "${nixpkgs}/nixos/modules/virtualisation/linode-image.nix"

          ./services/openssh.nix
          ./services/fail2ban.nix

          ./extra/HentaiAtHome.nix
          ./extra/book-searcher.nix
          ./extra/nginx-book.nix

          ./metrics/node_exporter.nix
          ./metrics/prometheus.nix
          ./metrics/grafana.nix
        ];
      };

      # nix build .#linode-image.x86_64-linux -v -L
      linode-image = linode.config.system.build.linodeImage;

      deploy.nodes.linode = {
        sshUser = "root";
        hostname = "172.105.209.227";

        profiles.system.path =
          deploy-rs.lib."${system}".activate.nixos
            linode;
      };
    };
}
