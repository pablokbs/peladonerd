#
# Exportamos nuestra key SSH

resource "digitalocean_ssh_key" "imcosta" {
  name       = "imcosta"
  public_key = file("id_rsa.pub")
}

