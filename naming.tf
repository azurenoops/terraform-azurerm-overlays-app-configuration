# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#------------------------------------------------------------
# Azure NoOps Naming - This should be used on all resource naming
#------------------------------------------------------------
data "azurenoopsutils_resource_name" "app_configuration_name" {
  name          = var.workload_name
  resource_type = "azurerm_app_configuration"
  prefixes      = [var.org_name, var.use_location_short_name ? module.mod_azregions.location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.environment, local.name_suffix, var.use_naming ? "" : "appconfig"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}

data "azurenoopsutils_resource_name" "app_configuration_pe" {
  name          = var.workload_name
  resource_type = "azurerm_private_endpoint"
  prefixes      = [var.org_name, var.use_location_short_name ? module.mod_azregions.location_short : module.mod_azregions.location_cli]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.environment, local.name_suffix, var.use_naming ? "" : "pe"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}