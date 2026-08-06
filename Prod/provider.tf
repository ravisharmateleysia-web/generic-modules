terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rv1"
    storage_account_name = "rvstorage22"
    container_name       = "rvcontainer"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}