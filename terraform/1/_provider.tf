variable "digitalocean_token" {}

terraform {
  required_version = ">= 0.14.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.digitalocean_token
}

