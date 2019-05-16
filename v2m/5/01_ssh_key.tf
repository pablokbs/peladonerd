#
# Exportamos nuestra key SSH
# Tenes que copiar tu key a este directorio para que esto funcione

resource "digitalocean_ssh_key" "pelado" {
  name       = "pelado"
  public_key = "${file("id_rsa.pub")}"
}

