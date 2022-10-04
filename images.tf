locals {
  # TODO: Edit this line when changing; or use "local-exec".
  img_name = "nixos-image-22.05.20221003.81a3237-x86_64-linux.img.gz"
}

// noinspection MissingProperty
resource "linode_image" "nixos" {
  label = "nixos"

  file_path = "result/${local.img_name}"
  file_hash = filemd5("result/${local.img_name}")

  // TODO: Use "ap-northeast" instead.
  region = "us-east"
}
