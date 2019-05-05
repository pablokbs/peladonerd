resource "digitalocean_loadbalancer" "public" {
  name = "loadbalancer-1"
  region = "nyc1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 30000
    target_protocol = "http"
  }

  healthcheck {
    port = 30000
    protocol = "tcp"
  }

  droplet_tag = "pelado-nodes"
}