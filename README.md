# Azure App Configuration Overlay Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurenoops/overlays-app-configuration/azurerm/)

This Overlay terraform module creates an [Azure App Configuration](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview) with optional Key Vault for encryption enabled to be used in a [SCCA compliant Management Network](https://registry.terraform.io/modules/azurenoops/overlays-management-hub/azurerm/latest). This module has also key and feature management capabilities.

## Using Azure Clouds

Since this module is built for both public and us government clouds. The `environment` variable defaults to `public` for Azure Cloud. When using this module with the Azure Government Cloud, you must set the `environment` variable to `usgovernment`. You will also need to set the azurerm provider `environment` variable to the proper cloud as well. This will ensure that the correct Azure Government Cloud endpoints are used. You will also need to set the `location` variable to a valid Azure Government Cloud location.

Example Usage for Azure Government Cloud:

```hcl

provider "azurerm" {
  environment = "usgovernment"
}

module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  location = "usgovvirginia"
  environment = "usgovernment"
  ...
}

```

### Resource Provider List

Terraform requires the following resource providers to be available:

- Microsoft.Network
- Microsoft.Storage
- Microsoft.Compute
- Microsoft.KeyVault
- Microsoft.Authorization
- Microsoft.Resources
- Microsoft.OperationalInsights
- Microsoft.GuestConfiguration
- Microsoft.Insights
- Microsoft.Advisor
- Microsoft.Security
- Microsoft.OperationsManagement
- Microsoft.AAD
- Microsoft.AlertsManagement
- Microsoft.Authorization
- Microsoft.AnalysisServices
- Microsoft.Automation
- Microsoft.Subscription
- Microsoft.Support
- Microsoft.PolicyInsights
- Microsoft.SecurityInsights
- Microsoft.Security
- Microsoft.Monitor
- Microsoft.Management
- Microsoft.ManagedServices
- Microsoft.ManagedIdentity
- Microsoft.Billing
- Microsoft.Consumption

Please note that some of the resource providers may not be available in Azure Government Cloud. Please check the [Azure Government Cloud documentation](https://docs.microsoft.com/en-us/azure/azure-government/documentation-government-get-started-connect-with-cli) for more information.

## SCCA Compliance

This module can be SCCA compliant and can be used in a SCCA compliant Network. Enable private endpoints and SCCA compliant network rules to make it SCCA compliant.

For more information, please read the [SCCA documentation]("https://www.cisa.gov/secure-cloud-computing-architecture").

## Contributing

If you want to contribute to this repository, feel free to to contribute to our Terraform module.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Resources Supported

- [Azure App Configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration)
- [Azure App Configuration Key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_key)
- [Azure App Configuration Feature Flag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_feature)
- [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [Private Link service/Endpoint network policies on Subnet](https://www.terraform.io/docs/providers/azurerm/r/subnet.html#enforce_private_link_endpoint_network_policies)

## Module Usage

```terraform
# Azurerm provider configuration
provider "azurerm" {
  features {}
}

module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  create_app_config_resource_group = true
  location                         = "eastus"
  deploy_environment               = "dev"
  org_name                         = "anoa"
  environment                      = "public"
  workload_name                    = "app-config"
  
}
```

## Configuing App Configuration with Purge Protection

To enable purge protection for the App Configuration, set the `enable_purge_protection` variable to `true`. This will enable purge protection for the App Configuration. It defaults to `false`. This field only works for `standard` sku

### Use with Purge Protection

```terraform
module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  create_app_config_resource_group = true
  location                         = "eastus"
  deploy_environment               = "dev"
  org_name                         = "anoa"
  environment                      = "public"
  workload_name                    = "app-config"

  # Sku
  sku = "standard"
  
  # Purge Protection Configuration
  enable_purge_protection = true
}
```

## Configuing App Configuration with Soft Delete Deletion days

To configure soft deletetion days for the App Configuration, set the `soft_delete_retention_days` variable to number of days that items should be retained for once soft-deleted. This will enable soft delete for the App Configuration. This value can be between `1 and 7` days. Defaults to 7. This field only works for `standard` sku

### Use with Soft Delete

```terraform
module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  create_app_config_resource_group = true
  location                         = "eastus"
  deploy_environment               = "dev"
  org_name                         = "anoa"
  environment                      = "public"
  workload_name                    = "app-config"

  # Sku
  sku = "standard"
  
  # Soft Delete Configuration
  enable_soft_delete = true
}
```

## Using App Configuration with User Assigned Identity

To use a user assigned identity with the App Configuration module, set the `identity_type` variable to `UserAssigned`. Add the `existing_principal_ids` variable to the module and set it to the user assigned identity ids. The user assigned identity must be in the same region and subscription where the App Configuration resides.

### Use with User Assigned Identity

```terraform
module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  create_app_config_resource_group = true
  location                         = "eastus"
  deploy_environment               = "dev"
  org_name                         = "anoa"
  environment                      = "public"
  workload_name                    = "app-config"
  
  # User Assigned Identity Configuration
  identity_type = "UserAssigned"
  existing_principal_ids = ["<user_assigned_identity_ids>"]
}
```

## Using App Configuration Encryption with Existing Key Vault

To use encryption with the App Configuration module, set the `existing_key_vault_id` and `existing_key_vault_principal_object_id` variables to a existing Key Vault for the App Configuration to use.

> **Note**: The `existing_key_vault_id` and `existing_key_vault_principal_object_id` variables are required when using an existing key vault. The existing key vault must be in the same region and subscription where the App Configuration resides.

### Use with Key Vault

```terraform
module "overlays-app-configuration" {
  source  = "azurenoops/overlays-app-configuration/azurerm"
  version = "x.x.x"
  
  create_app_config_resource_group = true
  location                         = "eastus"
  deploy_environment               = "dev"
  org_name                         = "anoa"
  environment                      = "public"
  workload_name                    = "app-config"
  
  # Key Vault Configuration
  existing_key_vault_id = "<key_vault_id>"
  existing_key_vault_principal_object_id = "<object_id>"
}
```

## Recommended naming and tagging conventions

Applying tags to your Azure resources, resource groups, and subscriptions to logically organize them into a taxonomy. Each tag consists of a name and a value pair. For example, you can apply the name `Environment` and the value `Production` to all the resources in production.
For recommendations on how to implement a tagging strategy, see Resource naming and tagging decision guide.

>**Important** :
Tag names are case-insensitive for operations. A tag with a tag name, regardless of the casing, is updated or retrieved. However, the resource provider might keep the casing you provide for the tag name. You'll see that casing in cost reports. **Tag values are case-sensitive.**

An effective naming convention assembles resource names by using important resource information as parts of a resource's name. For example, using these [recommended naming conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging#example-names), a public IP resource for a production SharePoint workload is named like this: `pip-sharepoint-prod-westus-001`.

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->