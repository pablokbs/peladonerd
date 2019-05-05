resource "digitalocean_kubernetes_cluster" "pelado" {
  name    = "pelado"
  region  = "nyc1"
  version = "1.13.4-do.0"

  node_pool {
    name       = "pelado-nodes"
    size       = "s-1vcpu-2gb"
    node_count = 1
    tags = ["pelado-nodes"]
  }
}
