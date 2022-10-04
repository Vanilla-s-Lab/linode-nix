// noinspection MissingProperty
resource "linode_image" "nixos" {
  label = "nixos"

  file_path = "result/nixos.img.gz"
  file_hash = filemd5("result/nixos.img.gz")

  // TODO: Use "ap-northeast" instead.
  region = "us-east"
}
