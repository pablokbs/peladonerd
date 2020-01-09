# Creamos un dominio nuevo

resource "digitalocean_domain" "pablokbs" {
  name = "pablokbs.com"
}

# Add a record to the domain
resource "digitalocean_record" "mail" {
  domain = "${digitalocean_domain.pablokbs.name}"
  type   = "A"
  name   = "mail"
  ttl    = "30"
  value  = "${digitalocean_droplet.mail.ipv4_address}"
}

# Add mx record to the domain (so it can receive emails)
resource "digitalocean_record" "mx" {
  domain = "${digitalocean_domain.pablokbs.name}"
  type   = "MX"
  name   = "@"
  priority    = "10"
  ttl    = "14400"
  value  = "mail.${digitalocean_domain.pablokbs.name}."
}