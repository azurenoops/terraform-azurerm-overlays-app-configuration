# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

output "app_configuration_id" {
  value = module.mod_app_configuration.id  
}

output "app_configuration_name" {
  value = module.mod_app_configuration.name
}

output "app_configuration_endpoint" {
  value = module.mod_app_configuration.endpoint
}

output "app_configuration_identity_principal_id" {
  value = module.mod_app_configuration.identity_principal_id
}