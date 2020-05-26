terraform {
  backend "azurerm" {
    resource_group_name   = "lpm-eastus2-tfstate-rg"
    storage_account_name  = "lpmtfstateeastus2sa"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  version = "2.11.0"
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}


resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-${var.location}-example-rg"
  location = var.location
  tags     = var.tags
}


