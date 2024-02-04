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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurenoopsutils"></a> [azurenoopsutils](#requirement\_azurenoopsutils) | ~> 1.0.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurenoopsutils"></a> [azurenoopsutils](#provider\_azurenoopsutils) | ~> 1.0.4 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mod_azregions"></a> [mod\_azregions](#module\_mod\_azregions) | azurenoops/overlays-azregions-lookup/azurerm | ~> 1.0.0 |
| <a name="module_mod_scaffold_rg"></a> [mod\_scaffold\_rg](#module\_mod\_scaffold\_rg) | azurenoops/overlays-resource-group/azurerm | ~> 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.app_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |
| [azurerm_app_configuration_feature.feature](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_feature) | resource |
| [azurerm_app_configuration_key.test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration_key) | resource |
| [azurerm_role_assignment.appconf_dataowner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurenoopsutils_resource_name.example_custom_name](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_tags"></a> [add\_tags](#input\_add\_tags) | Map of custom tags. | `map(string)` | `{}` | no |
| <a name="input_app_configuration_features"></a> [app\_configuration\_features](#input\_app\_configuration\_features) | A map of App Configuration features | <pre>map(object({<br>    description = string<br>    name        = string<br>    label       = string<br>    enabled     = bool<br>  }))</pre> | `null` | no |
| <a name="input_app_configuration_keys"></a> [app\_configuration\_keys](#input\_app\_configuration\_keys) | A list of keys to create in the App Configuration | <pre>map(object({<br>    label = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_create_app_config_resource_group"></a> [create\_app\_config\_resource\_group](#input\_create\_app\_config\_resource\_group) | Controls if the resource group should be created. If set to false, the resource group name must be provided. Default is false. | `bool` | `false` | no |
| <a name="input_custom_app_configuration_name"></a> [custom\_app\_configuration\_name](#input\_custom\_app\_configuration\_name) | The name of the custom app configuration to create. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables. | `string` | `null` | no |
| <a name="input_custom_resource_group_name"></a> [custom\_resource\_group\_name](#input\_custom\_resource\_group\_name) | The name of the custom resource group to create. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables. | `string` | `null` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_deploy_environment"></a> [deploy\_environment](#input\_deploy\_environment) | Name of the workload's environment | `string` | n/a | yes |
| <a name="input_enable_purge_protection"></a> [enable\_purge\_protection](#input\_enable\_purge\_protection) | Whether Purge Protection is enabled. This field only works for `standard` SKU. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Terraform backend environment e.g. public or usgovernment | `string` | n/a | yes |
| <a name="input_existing_key_vault_id"></a> [existing\_key\_vault\_id](#input\_existing\_key\_vault\_id) | The ID of an existing Key Vault to use for App Configuration. | `string` | `null` | no |
| <a name="input_existing_key_vault_principal_object_id"></a> [existing\_key\_vault\_principal\_object\_id](#input\_existing\_key\_vault\_principal\_object\_id) | The principal ID of an existing Key Vault to use for App Configuration. | `string` | `null` | no |
| <a name="input_existing_principal_id"></a> [existing\_principal\_id](#input\_existing\_principal\_id) | The principal ID of an existing service principal to use for the App Configuration Data Owner role assignment. If not provided, the current service principal will be used. | `string` | `null` | no |
| <a name="input_existing_principal_ids"></a> [existing\_principal\_ids](#input\_existing\_principal\_ids) | The principal ID of an existing principal ids to use for App Configuration. | `list(string)` | `null` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | The name of the existing resource group to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables. | `string` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | App configuration identity type. Possible values are `null` `UserAssigned` and `SystemAssigned`. | `string` | `"SystemAssigned"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication methods is enabled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region in which instance will be hosted | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Optional prefix for the generated name | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Optional suffix for the generated name | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the organization | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_replica_location"></a> [replica\_location](#input\_replica\_location) | The location of the replica. Defaults to `East US`. Must be a valid Azure location. | `string` | `"East US"` | no |
| <a name="input_replica_name"></a> [replica\_name](#input\_replica\_name) | The name of the replica. | `string` | `"secondary"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the App Configuration. Possible values are `free` and `standard`. Defaults to `standard`. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This field only works for `standard` sku. This value can be between `1 and 7` days. Defaults to 7. Changing this forces a new resource to be created. | `number` | `7` | no |
| <a name="input_use_location_short_name"></a> [use\_location\_short\_name](#input\_use\_location\_short\_name) | Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored. | `bool` | `true` | no |
| <a name="input_use_naming"></a> [use\_naming](#input\_use\_naming) | Use the Azure NoOps naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | Name of the workload\_name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_configuration"></a> [app\_configuration](#output\_app\_configuration) | App Configuration output object |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | App Configuration Endpoint URL |
| <a name="output_id"></a> [id](#output\_id) | App Configuration ID |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | App Configuration system identity principal ID |
| <a name="output_name"></a> [name](#output\_name) | App Configuration name |
| <a name="output_primary_read_key"></a> [primary\_read\_key](#output\_primary\_read\_key) | App Configuration primary read key |
| <a name="output_primary_write_key"></a> [primary\_write\_key](#output\_primary\_write\_key) | App Configuration primary write key |
| <a name="output_secondary_read_key"></a> [secondary\_read\_key](#output\_secondary\_read\_key) | App Configuration secondary read key |
| <a name="output_secondary_write_key"></a> [secondary\_write\_key](#output\_secondary\_write\_key) | App Configuration secondary write key |
<!-- END_TF_DOCS -->