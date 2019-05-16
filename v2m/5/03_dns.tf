# Creamos un dominio nuevo

resource "digitalocean_domain" "pablokbs" {
  name = "pablokbs.com"
}

# Add a record to the domain
resource "digitalocean_record" "git" {
  domain = "${digitalocean_domain.pablokbs.name}"
  type   = "A"
  name   = "git"
  ttl    = "10"
  value  = "${digitalocean_droplet.git.ipv4_address}"
}

