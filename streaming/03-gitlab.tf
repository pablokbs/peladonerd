#
# Exportamos nuestra key SSH
resource "digitalocean_ssh_key" "pelado" {
  name       = "pelado"
  public_key = "${file("id_rsa.pub")}"
}

# Creamos el droplet
resource "digitalocean_droplet" "gitlab" {
  image     = "ubuntu-18-04-x64"
  name      = "gitlab-1"
  region    = "nyc1"
  size      = "s-2vcpu-4gb"
  user_data = "${file("userdata.yaml")}"
  ssh_keys  = ["${digitalocean_ssh_key.pelado.fingerprint}"]
}

# Creamos un dominio nuevo
resource "digitalocean_domain" "mydomain" {
  name = "example.com"
}

# Add a record to the domain
resource "digitalocean_record" "git" {
  domain = "${digitalocean_domain.mydomain.name}"
  type   = "A"
  name   = "git"
  value  = "${digitalocean_droplet.gitlab.ipv4_address}"
}

