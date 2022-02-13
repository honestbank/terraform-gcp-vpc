terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "honestbank"

    workspaces {
      name = "terraform-gcp-vpc"
    }
  }

  required_version = "~> 1.0"
}
