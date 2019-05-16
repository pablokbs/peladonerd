#
# Creamos el droplet

resource "digitalocean_droplet" "git" {
  image     = "ubuntu-18-04-x64"
  name      = "git.pablokbs.com"
  region    = "nyc1"
  size      = "s-1vcpu-2gb"
  user_data = "${file("userdata.yaml")}"
  ssh_keys  = ["${digitalocean_ssh_key.pelado.fingerprint}"]
}
