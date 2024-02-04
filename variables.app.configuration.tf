# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


######################################
# App Configuration Configuration   ##
######################################

variable "sku" {
  description = "The SKU name of the App Configuration. Possible values are `free` and `standard`. Defaults to `standard`."
  type        = string
  default     = "standard"
}

variable "enable_purge_protection" {
  description = "Whether Purge Protection is enabled. This field only works for `standard` SKU. Defaults to `false`."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This field only works for `standard` sku. This value can be between `1 and 7` days. Defaults to 7. Changing this forces a new resource to be created."
  type        = number
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days == null || (var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 7)
    error_message = "`soft_delete_retention_days` must be between 1 and 7 days."
  }
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods is enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "App configuration identity type. Possible values are `null` `UserAssigned` and `SystemAssigned`."
  type        = string
  default     = "SystemAssigned"
}

variable "existing_principal_ids" {
  description = "The principal ID of an existing principal ids to use for App Configuration."
  type        = list(string)
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled. Defaults to `true`."
  type        = bool
  default     = true
}

variable "replica_name" {
  description = "The name of the replica."
  type        = string
  default     = "secondary"  
}

variable "replica_location" {
  description = "The location of the replica. Defaults to `East US`. Must be a valid Azure location."
  type        = string
  default     = "East US"
}