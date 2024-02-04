# Azure App Configuration Overlay Terraform Module

This terraform overlay module deploys an Azure App Configuration with Replica.

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
  
  # Resource Group, location, VNet and Subnet details
  create_app_config_resource_group = true
  location                         = var.location
  deploy_environment               = var.deploy_environment
  org_name                         = var.org_name
  workload_name                    = var.workload_name
  environment                      = var.environment

  # Replica Configuration
  replica_name = "app-config-replica"
  replica_location = "West US"

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
