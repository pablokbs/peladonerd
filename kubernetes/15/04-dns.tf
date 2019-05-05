# Creamos un dominio nuevo

resource "digitalocean_domain" "pablokbs" {
  name = "pablokbs.com"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.pablokbs.name}"
  type   = "A"
  name   = "www"
  ttl    = "10"
  value  = "${digitalocean_loadbalancer.public.ip}"
}

