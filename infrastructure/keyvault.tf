resource "azurerm_key_vault" "example" {
  name                        = "${var.prefix}-example-kv"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tags                        = var.tags
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
}

resource "azurerm_key_vault_access_policy" "admin" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete"
  ]
}