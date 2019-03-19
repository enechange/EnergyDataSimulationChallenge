variable "heroku_email" {}
variable "heroku_api_key" {}
variable "gcs_credential_file" {}

terraform {
  backend "gcs" {
    bucket  = "complimentary-terraform-state"
    prefix  = "EnergyDataSimulationChallenge"
  }
}

provider "heroku" {
  email   = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "eds-challenge" {
  name   = "eds-challenge"
  region = "us"
}
