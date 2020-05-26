provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "${var.prefix}-${var.location}-tfstate-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.prefix}tfstate${var.location}sa"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  tags                     = var.tags
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}