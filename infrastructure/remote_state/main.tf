locals {
  settings = yamldecode(file("../../environments/10mdeveastus/terraform.yaml"))
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = local.settings.stateRg
  location = local.settings.stateRgLocation
}

resource "azurerm_storage_account" "tfstate" {
  name                     = local.settings.stateSA
  resource_group_name      = local.settings.stateRg
  location                 = local.settings.stateRgLocation
  account_tier             = local.settings.stateSATier
  account_replication_type = local.settings.stateSARepType
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = local.settings.stateSA
  container_access_type = "private"
}