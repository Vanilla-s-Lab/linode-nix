{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, nixos-generators, ... }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system: rec {
      pkgs = nixpkgs.legacyPackages."${system}";

      devShell = pkgs.mkShell {
        shellHook = ''
          export LINODE_TOKEN=(cat /run/secrets/linode-nix/token)
        '';
      };

      linode = nixos-generators.nixosGenerate {
        inherit system;
        format = "linode";
      };
    });
}
