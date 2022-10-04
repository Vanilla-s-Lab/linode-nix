resource "linode_instance" "nixos" {
  # https://api.linode.com/v4/regions
  region = "ap-northeast" # jp

  image = linode_image.nixos.id

  # https://api.linode.com/v4/linode/types
  type  = "g6-nanode-1"
  label = "nixos"
}

output "ip_address" {
  value = linode_instance.nixos.ip_address
}
