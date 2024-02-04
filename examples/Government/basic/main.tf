# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Terraform module for deploying a basic App Configuration in Azure. 

module "mod_app_configuration" {
  #source  = "azurenoops/overlays-app-configuration/azurerm"
  #version = "x.x.x"
  source = "../../.."

  # Resource Group, location, VNet and Subnet details
  create_app_config_resource_group = true
  location                         = var.location
  deploy_environment               = var.deploy_environment
  org_name                         = var.org_name
  workload_name                    = var.workload_name
  environment                      = var.environment

  # Adding additional TAG's to your Azure resources
  add_tags = {
    Example = "basic_app_configuration"
  }
}
