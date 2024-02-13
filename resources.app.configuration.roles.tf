# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------
# Role Assignments for App Configuration
#---------------------------------------------------------

resource "azurerm_role_assignment" "data_readers" {
  count = length(var.data_reader_identities)

  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = var.data_reader_identities[count.index]
}

resource "azurerm_role_assignment" "data_owners" {
  count = length(var.data_owner_identities)

  scope                = azurerm_app_configuration.app_configuration.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = var.data_owner_identities[count.index]
}