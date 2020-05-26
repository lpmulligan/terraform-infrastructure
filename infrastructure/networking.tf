resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-${var.location}-example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags                = var.tags
  address_space       = var.address_space
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-${var.location}-example-apps-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = var.address_prefix
}
