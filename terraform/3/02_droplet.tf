#
# Creamos el droplet

variable "domain" {}

resource "digitalocean_droplet" "mail" {
  image     = "debian-10-x64"
  name      = "mail.${var.domain}"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  user_data = file("userdata.yaml")
  ssh_keys  = ["${digitalocean_ssh_key.key.fingerprint}"]
}
