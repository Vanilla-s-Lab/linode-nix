resource "linode_image" "nixos" {
  label = "nixos"

  // https://stackoverflow.com/questions/66069677/get-an-element-from-a-list-terraform
  file_path = "result/nixos-image-22.11.20221231.feda52b-x86_64-linux.img.gz"
  file_hash = "a034ce957205d565539d6f904c5ef207"

  region = "us-east"
}

output "file_path" { value = linode_image.nixos.file_path }
output "file_hash" { value = linode_image.nixos.file_hash }
