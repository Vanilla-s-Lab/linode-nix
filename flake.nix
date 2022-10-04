{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  };

  outputs = { nixpkgs, ... }:
    let system = "x86_64-linux"; in
    let pkgs = import nixpkgs { inherit system; }; in
    { devShell."${system}" = pkgs.mkShell { }; };
}
