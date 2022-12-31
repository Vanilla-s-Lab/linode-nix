{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { nixpkgs, deploy-rs, ... }:
    let system = "x86_64-linux"; in
    rec {
      pkgs = import nixpkgs {
        inherit system;
      };

      linode = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [{ system.stateVersion = "22.11"; }]
          ++ [ ./system/users.nix ./system/network.nix ./services/openssh.nix ] ++ [
          "${nixpkgs}/nixos/modules/virtualisation/linode-config.nix"
          "${nixpkgs}/nixos/modules/virtualisation/linode-image.nix"
        ] ++ [ ./services/fail2ban.nix ./system/boot.nix ./services/nginx.nix ];
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
