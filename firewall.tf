resource "linode_firewall" "nixos" {
  label   = "nixos"
  linodes = [linode_instance.nixos.id]

  inbound {
    label    = "allow-DHCP"
    protocol = "UDP"
    ports    = "67,68"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "accept-inbound-SSH"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-HTTP"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-HTTPS"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }
}
