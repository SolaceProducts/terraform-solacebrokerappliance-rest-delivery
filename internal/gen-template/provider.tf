# Terraform configuration

terraform {
  required_providers {
    solacebroker = {
      source  = "registry.terraform.io/solaceproducts/solacebrokerappliance"
      version = "~> 0.9"
    }
  }
}
