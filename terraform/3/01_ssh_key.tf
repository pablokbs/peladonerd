#
# Exportamos nuestra key SSH

resource "digitalocean_ssh_key" "key" {
  name       = "key"
  public_key = file("id_rsa.pub")
}

