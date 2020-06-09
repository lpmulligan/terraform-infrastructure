resource "azurerm_subnet" "subnet" {
  name                   = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-SN"
  resource_group_name    = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-${local.settings.rg}"
  virtual_network_name   = local.settings.vnet.name
  address_prefixes       = local.settings.vnet.subnet_prefixes
}