variable "digitalocean_token" {}

variable "circleci_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

provider "circleci" {
  api_token    = "${var.circleci_token}"
  vcs_type     = "github"
  organization = "peladonerd"
}