terraform {
  cloud {
    organization = "Vanilla-s-Lab"

    workspaces {
      name = "linode-nix"
    }
  }
}
