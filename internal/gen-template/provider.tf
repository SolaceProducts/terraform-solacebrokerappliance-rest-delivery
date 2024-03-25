# Terraform configuration

terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
      version = "~> 0.9"
    }
  }
}
