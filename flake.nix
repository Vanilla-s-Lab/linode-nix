{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, deploy-rs, sops-nix, nixos-cn, ... }:

    let system = "x86_64-linux"; in
    let pkgs = nixpkgs.legacyPackages.${system}; in
    let generated = pkgs.callPackage ./_sources/generated.nix { }; in

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
          ./services/bird2.nix
          ./metrics/bird_exporter.nix

          ./sops-config/wireguard-keys.nix
          ./services/wireguard.nix

          ./extra/HentaiAtHome.nix
          ./extra/book-searcher.nix
          ./extra/nginx-book.nix
          ./extra/vaultwarden.nix

          ./metrics/node_exporter.nix
          ./metrics/prometheus.nix
          ./metrics/grafana.nix
          ./metrics/nginx-exporter.nix

          sops-nix.nixosModules.sops
          nixos-cn.nixosModules.nixos-cn

          ./sops-config/csgo_exporter.nix
          ./metrics/csgo_exporter.nix
        ];

        specialArgs = { inherit generated; };
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

      csgo_exporter = pkgs.callPackage ./pkgs/csgo_exporter.nix { inherit generated; };
    };
}
