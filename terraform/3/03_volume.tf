
resource "digitalocean_volume" "mail" {
  region                  = "nyc1"
  name                    = "mail"
  size                    = 5
  initial_filesystem_type = "ext4"
  description             = "Email disk"
  lifecycle {
    prevent_destroy = true
  }
}

resource "digitalocean_volume_attachment" "mail" {
  droplet_id = digitalocean_droplet.mail.id
  volume_id  = digitalocean_volume.mail.id
}
