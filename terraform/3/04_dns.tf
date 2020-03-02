# Creamos un dominio nuevo

# Add a record to the domain
resource "digitalocean_record" "mail" {
  domain =  var.domain
  type   = "A"
  name   = "mail"
  ttl    = "30"
  value  = digitalocean_droplet.mail.ipv4_address
}

# Add mx record to the domain (so it can receive emails)
resource "digitalocean_record" "mx" {
  domain = var.domain
  type   = "MX"
  name   = "@"
  priority    = "10"
  ttl    = "14400"
  value  = "mail.${var.domain}."
}

# SPF
resource "digitalocean_record" "spf" {
  domain = var.domain
  type   = "TXT"
  name   = "@"
  ttl    = "14400"
  value  = "v=spf1 mx ~all"
}

# DMARC
resource "digitalocean_record" "dmarc" {
  domain = var.domain
  type   = "TXT"
  name   = "_dmarc.${var.domain}"
  ttl    = "14400"
  value  = "v=DMARC1; p=none; rua=mailto:dmarc-reports@${var.domain}"
}

# SMTP
resource "digitalocean_record" "smtp" {
  domain = var.domain
  type   = "CNAME"
  name   = "smtp"
  ttl    = "14400"
  value  = "mail.${var.domain}."
}

# POP
resource "digitalocean_record" "pop" {
  domain = var.domain
  type   = "CNAME"
  name   = "pop"
  ttl    = "14400"
  value  = "mail.${var.domain}."
}

# IMAP
resource "digitalocean_record" "imap" {
  domain = var.domain
  type   = "CNAME"
  name   = "imap"
  ttl    = "14400"
  value  = "mail.${var.domain}."
}