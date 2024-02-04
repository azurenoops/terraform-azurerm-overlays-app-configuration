# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
# Azure App Configuration Role Assignment
#---------------------------------------------------------------
resource "azurerm_role_assignment" "appconf_dataowner" {
  count                = var.app_configuration_keys != null || var.app_configuration_features != null ? 1 : 0
  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = var.existing_principal_id == null ? data.azurerm_client_config.current.object_id : var.existing_principal_id
}
