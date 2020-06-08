locals {
  settings = yamldecode(file("../environments/10mdeveastus/terraform.yaml"))
}

terraform {
  backend "azurerm" {
    resource_group_name   = "jn-eastus2-tfstate-rg"
    storage_account_name  = "jntfstateeastus2sa"
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
  name     = "${local.settings.rgPrefix.EUS}-test-${local.settings.rg}"
  location = local.settings.location
}