resource "azurerm_key_vault" "kv" {
  name                        = local.settings.keyvault.name
  location                    = local.settings.keyvault.location
  resource_group_name         = "${local.settings.rgPrefix.EUS}test-${local.settings.rg}"
  tags                        = local.settings.keyvault.tags
  enabled_for_disk_encryption = local.settings.keyvault.encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = local.settings.keyvault.sku_name
}

#resource "azurerm_key_vault_access_policy" "admin" {
 # key_vault_id = azurerm_key_vault.example.id
 # tenant_id    = data.azurerm_client_config.current.tenant_id
 # object_id    = data.azurerm_client_config.current.object_id

  #secret_permissions = [
  #  "get",
  #  "list",
  #  "set",
  #  "delete"
  #]
#}