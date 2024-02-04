# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

###############################
# Key Vault Configuration   ##
###############################

variable "existing_key_vault_id" {
  description = "The ID of an existing Key Vault to use for App Configuration."
  type        = string
  default     = null  
}

variable "existing_key_vault_principal_object_id" {
  description = "The principal ID of an existing Key Vault to use for App Configuration."
  type        = string
  default     = null    
}