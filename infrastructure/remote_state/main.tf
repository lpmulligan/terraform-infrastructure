locals {
  settings = yamldecode(file("../../environments/10mdeveastus/terraform.yaml"))
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "AZ-EUS-TFSTATE-10MDEV-RG"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "azeastus10mdevtfstate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  tags                     = var.tags
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}