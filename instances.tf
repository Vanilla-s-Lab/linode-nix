resource "linode_instance" "nixos" {
  # https://api.linode.com/v4/regions
  region = "ap-northeast" # jp

  # https://api.linode.com/v4/linode/types
  type   = "g6-nanode-1"
  label  = "nixos"
  booted = true
}

output "ip_address" {
  value = linode_instance.nixos.ip_address
}

locals {
  swap_size = 512
}

# https://github.com/houstdav000/terranix-linode-poc/blob/main/config.nix

resource "linode_instance_disk" "boot" {
  linode_id = linode_instance.nixos.id
  label     = "boot"

  # https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance_disk
  size = linode_instance.nixos.specs.0.disk - local.swap_size

  image     = linode_image.nixos.id
  root_pass = "users.mutableUsers"
}

resource "linode_instance_disk" "swap" {
  linode_id = linode_instance.nixos.id
  label     = "swap"
  size      = local.swap_size

  filesystem = "swap"
}

resource "linode_instance_config" "nixos" {
  linode_id = linode_instance.nixos.id
  label     = "nixos"
  booted    = true

  # https://api.linode.com/v4/linode/kernels
  kernel = "linode/grub2"

  // noinspection HCLUnknownBlockType
  helpers {
    devtmpfs_automount = false
    distro             = false
    modules_dep        = false
    network            = false
    updatedb_disabled  = false
  }

  // noinspection HCLUnknownBlockType
  devices {
    // noinspection HCLUnknownBlockType
    sda { disk_id = linode_instance_disk.boot.id }
    // noinspection HCLUnknownBlockType
    sdb { disk_id = linode_instance_disk.swap.id }
  }

  // noinspection HCLUnknownBlockType
  interface {
    purpose = "public"
  }
}
