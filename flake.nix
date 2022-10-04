{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, flake-utils, nixpkgs-unstable, ... }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system: rec {
      pkgs = nixpkgs.legacyPackages."${system}";

      linode = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [ ./users.nix ./network.nix ./openssh.nix ] ++ [
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-config.nix"
          "${nixpkgs-unstable}/nixos/modules/virtualisation/linode-image.nix"
        ];
      };

      linode-image = linode.config.system.build.linodeImage;
    });
}
