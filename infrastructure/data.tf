data "azurerm_virtual_network" "devvirtualnetwork" {
  name                = local.settings.vnet.name
  location            = local.settings.location
  resource_group_name = local.settings.vnet.rg
}
