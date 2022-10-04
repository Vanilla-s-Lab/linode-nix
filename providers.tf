terraform {
  cloud {
    organization = "Vanilla-s-Lab"

    workspaces {
      name = "linode-nix"
    }
  }

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.29.2"
    }
  }
}

provider "linode" {
  token = "LINODE_TOKEN"
}
