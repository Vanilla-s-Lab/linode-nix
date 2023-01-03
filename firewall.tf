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
    label    = "accept-inbound-HAH-TCP"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-HAH-UDP"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-zlib-TCP"
    protocol = "TCP"
    ports    = "7070"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }

  inbound {
    label    = "accept-inbound-zlib-UDP"
    protocol = "TCP"
    ports    = "7070"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
    action   = "ACCEPT"
  }
}
