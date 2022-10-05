{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";

    sops-nix.url = "github:Mic92/sops-nix";
    nixos-cn.url = "github:nixos-cn/flakes";
  };

  outputs = { nixpkgs, nixpkgs-unstable, deploy-rs, sops-nix, nixos-cn, ... }:
    let system = "x86_64-linux"; in
    rec {
      pkgs = import nixpkgs {
        inherit system;
      };

      linode = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [ ./users.nix ./network.nix ./openssh.nix ] ++ [
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-config.nix"
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-image.nix"
        ] ++ [ ./fail2ban.nix ./wireguard.nix ./boot.nix ]
          ++ [ sops-nix.nixosModules.sops nixos-cn.nixosModules.nixos-cn ]
          ++ [ ./shadowsocks.nix ];
      };

      linode-image = linode.config.system.build.linodeImage;

      deploy.nodes.linode = {
        sshUser = "root";
        hostname = "139.162.105.188";

        profiles.system.path =
          deploy-rs.lib."${system}".activate.nixos
            linode;
      };

      fastConnection = true;
    };
}
