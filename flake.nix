{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system: rec {
      pkgs = nixpkgs.legacyPackages."${system}";
      devShell = pkgs.mkShell { };
    });
}
