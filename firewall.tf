resource "linode_firewall" "nixos" {
  label   = "nixos"
  linodes = [linode_instance.nixos.id]

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  // noinspection MissingProperty
  inbound {
    label  = "allow-ssh"
    action = "ACCEPT"

    # https://registry.terraform.io/providers/linode/linode/latest/docs/resources/firewall
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["::/0"]

    ports    = "22"
    protocol = "TCP"
  }
}
