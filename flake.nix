{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        linode = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [{ system.stateVersion = "22.11"; }]
            ++ [ ./system/users.nix ./system/network.nix ./services/openssh.nix ] ++ [
            "${nixpkgs}/nixos/modules/virtualisation/linode-config.nix"
            "${nixpkgs}/nixos/modules/virtualisation/linode-image.nix"
          ] ++ [ ./services/fail2ban.nix ./services/nginx.nix ];
        };

        # nix build .#linode-image.x86_64-linux -v -L
        linode-image = linode.config.system.build.linodeImage;
      }
    );
}
