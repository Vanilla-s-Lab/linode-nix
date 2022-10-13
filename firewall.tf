resource "linode_firewall" "nixos" {
  label   = "nixos"
  linodes = [linode_instance.nixos.id]

  // noinspection MissingProperty
  inbound {
    label    = "allow-dhcp"
    protocol = "UDP"
    ports    = "67,68"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  // noinspection MissingProperty
  inbound {
    label    = "accept-inbound-SSH"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }
}
