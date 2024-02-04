# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
# Azure App Configuration
#---------------------------------------------------------------
resource "azurerm_app_configuration" "app_configuration" {
  name = local.app_configuration_name

  location            = local.location
  resource_group_name = local.resource_group_name

  sku = var.sku

  public_network_access      = var.public_network_access_enabled ? "Enabled" : "Disabled"
  purge_protection_enabled   = var.enable_purge_protection
  soft_delete_retention_days = var.soft_delete_retention_days
  local_auth_enabled         = var.local_auth_enabled

  dynamic "identity" {
    for_each = var.identity_type[*]
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.existing_principal_ids : null
    }
  }

  dynamic "encryption" {
    for_each = var.existing_key_vault_id != null ? [1] : []
    content {
      key_vault_key_identifier = var.existing_key_vault_id
      identity_client_id       = var.existing_key_vault_principal_object_id
    }
  }

  replica {
    name     = var.replica_name
    location = var.replica_location
  }

  tags = merge(local.default_tags, var.add_tags)
}
