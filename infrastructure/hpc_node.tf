resource "azurerm_subnet" "dev10msubnet" {
  name                   = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-SN"
  resource_group_name    = data.azurerm_virtual_network.devvirtualnetwork.resource_group_name
  virtual_network_name   = local.settings.vnet.name
  address_prefixes       = local.settings.vnet.subnet_prefixes
}

resource "azurerm_network_interface" "hpcnode_nic" {
  count               = local.settings.hpcNode.count
  name                = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-${local.settings.hpcNode.type}-NI-${count.index +1}"
  location            = local.settings.location
  resource_group_name = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-${local.settings.rg}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev10msubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(azurerm_subnet.dev10msubnet.address_prefixes[0], "${count.index + 2}")
  }
}

resource "azurerm_windows_virtual_machine" "hpcnode" {
  count               = local.settings.hpcNode.count
  name                = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-${local.settings.hpcNode.type}-${count.index + 1}"
  resource_group_name = "${local.settings.cloud}-${local.settings.app}-${local.settings.env}-${local.settings.rg}"
  location            = local.settings.location
  size                = local.settings.hpcNode.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = ["${element(azurerm_network_interface.hpcnode_nic.*.id,count.index)}"]

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