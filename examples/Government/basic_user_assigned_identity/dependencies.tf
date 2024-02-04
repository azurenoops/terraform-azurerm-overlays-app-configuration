# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_resource_group" "app-config-rg" {
  name     = "app-config-rg"
  location = var.location
  tags = {
    environment = "test"
  }
}

resource "azurerm_user_assigned_identity" "app-config-id" {
  name                = "app-config-identity"
  location            = azurerm_resource_group.app-config-rg.location
  resource_group_name = azurerm_resource_group.app-config-rg.name
}
