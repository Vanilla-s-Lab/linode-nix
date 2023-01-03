locals {
  // https://www.terraform.io/language/functions/fileset
  img_files = fileset(path.module, "result/*.img.gz")
}

resource "linode_image" "nixos" {
  label = "nixos"

  // https://stackoverflow.com/questions/66069677/get-an-element-from-a-list-terraform
  file_path = tolist(local.img_files)[0]
  file_hash = filemd5(tolist(local.img_files)[0])

  region = "us-east"
}
