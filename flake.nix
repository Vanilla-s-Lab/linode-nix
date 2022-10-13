{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, deploy-rs, ... }:
    let system = "x86_64-linux"; in
    rec {
      pkgs = import nixpkgs {
        inherit system;
      };

      linode = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [{ system.stateVersion = "22.05"; }]
          ++ [ ./users.nix ./network.nix ./openssh.nix ] ++ [
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-config.nix"
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-image.nix"
        ] ++ [ ./fail2ban.nix ./boot.nix ./tailscale.nix ./headscale.nix ];
      };

      linode-image = linode.config.system.build.linodeImage;

      deploy.nodes.linode = {
        sshUser = "root";
        hostname = "139.162.105.188";

        # hostname = "221.131.165.89";
        # sshOpts = [ "-p" "50022" ];

        profiles.system.path =
          deploy-rs.lib."${system}".activate.nixos
            linode;
      };
    };
}
