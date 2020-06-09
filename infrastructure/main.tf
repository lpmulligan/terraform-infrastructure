locals {
  settings = yamldecode(file("../environments/10mdeveastus/terraform.yaml"))
}

terraform {
  backend "azurerm" {
    resource_group_name   = "AZ-EUS-TFSTATE-10MDEV-RG"
    storage_account_name  = "azeastus10mdevtfstate"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  version = "2.13.0"
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}


resource "azurerm_resource_group" "10mdev" {
  name     = "${local.settings.rgPrefix.EUS}-10MDEV-${local.settings.rg}"
  location = local.settings.location
}