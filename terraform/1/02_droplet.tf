#
# Creamos el droplet

resource "digitalocean_droplet" "web" {
  image     = "ubuntu-18-04-x64"
  name      = "web-1"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  user_data = "${file("userdata.yaml")}"
  ssh_keys  = ["${digitalocean_ssh_key.pelado.fingerprint}"]
}
