resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-${module.azure-region.location_short}-example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags                = var.tags
  address_space       = var.address_space
}
