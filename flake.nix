{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = { nixpkgs, ... }:
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
        ] ++ [ ./services/fail2ban.nix ./services/nginx.nix ];
      };

      linode-image = linode.config.system.build.linodeImage;
    };
}
