resource "linode_firewall" "default" {
  label   = "default"
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
    label    = "accept-inbound-HAH"
    protocol = "TCP"
    ports    = "33279"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-zlib-HTTP"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-zlib-HTTPS"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-WG"
    protocol = "UDP"
    ports    = "22688"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-BGP"
    protocol = "UDP"
    ports    = "179"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }
}
