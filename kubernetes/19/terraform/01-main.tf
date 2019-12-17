resource "digitalocean_kubernetes_cluster" "pelado" {
  name    = "pelado"
  region  = "nyc1"
  version = "1.16.2-do.1"

  node_pool {
    name       = "pelado-nodes"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}
