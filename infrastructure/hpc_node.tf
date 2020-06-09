resource "azurerm_subnet" "subnet" {
  name                   = "internal"
  resource_group_name    = "${local.settings.cloud}-EUS-${local.settings.nettype}-${local.settings.service}-${local.settings.rg}"
  virtual_network_name   = local.settings.vnet.name
  address_prefixes       = "${local.settings.vnet.subnet_prefix}"
}

resource "azurerm_network_interface" "interface" {
  name                = "example-nic"
  location            = local.settings.location
  resource_group_name = "${local.settings.cloud}-EUS-${local.settings.nettype}-${local.settings.service}-${local.settings.rg}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "hpcnode" {
  name                = "${local.settings.cloud}-${local.settings.app}-${local.settings.hpcNode.type}-${local.settings.hpcNode.index +1}-${local.settings.env}"
  resource_group_name = "${local.settings.cloud}-${local.settings.app}-10M-${local.settings.env}-${local.settings.rg}"
  location            = local.settings.location
  size                = local.settings.hpcNode.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}