#
# Exportamos nuestra key SSH

resource "digitalocean_ssh_key" "pelado" {
  name       = "pelado"
  public_key = "${file("id_rsa.pub")}"
}

