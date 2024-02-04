# Azure App Configuration Overlay Terraform Module

This terraform overlay module deploys an Azure App Configuration with User Assigned Identity.

## Module Usage for App Configuration with User Assigned Identity

```terraform
# Azurerm provider configuration
provider "azurerm" {
  environment = "usgovernment"
  features {}
}

module "mod_app_configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"

  depends_on = [
    azurerm_resource_group.app-config-rg,
  ]

  # Resource Group, location, VNet and Subnet details
  existing_resource_group_name = azurerm_resource_group.app-config-rg.name
  location                     = var.location
  deploy_environment           = var.deploy_environment
  org_name                     = var.org_name
  workload_name                = var.workload_name
  environment                  = var.environment

  # User Assigned Identity Configuration
  identity_type = "UserAssigned"
  existing_principal_ids = ["${azurerm_user_assigned_identity.app-config-id.principal_id}"]

  # Adding additional TAG's to your Azure resources
  add_tags = {
    Example = "basic_user_assigned_identity"
  }
}
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.
