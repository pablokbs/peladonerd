variable "digitalocean_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}