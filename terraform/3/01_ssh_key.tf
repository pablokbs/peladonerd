#
# Exportamos nuestra key SSH
# Acordate de reemplazar el archivo id_rsa.pub con tu key de ssh publica

resource "digitalocean_ssh_key" "key" {
  name       = "key"
  public_key = file("id_rsa.pub")
}

