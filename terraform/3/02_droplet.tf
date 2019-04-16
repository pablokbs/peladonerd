#
# Creamos el droplet

resource "digitalocean_droplet" "mail" {
  image     = "ubuntu-18-04-x64"
  name      = "mail.pablokbs.com"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  user_data = "${file("userdata.yaml")}"
  ssh_keys  = ["${digitalocean_ssh_key.pelado.fingerprint}"]
}
