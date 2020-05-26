terraform {
  backend "azurerm" {
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
  name     = "${var.prefix}-${module.azure-region.location_short}-example-rg"
  location = var.location
  tags     = var.tags
}


module "azure-region" {
  source  = "../modules/azure_region"
  azure_region = "eastus2"
}

