# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


##########################################
# App Configuration Key Configuration   ##
##########################################

variable "app_configuration_keys" {
  description = "A list of keys to create in the App Configuration"
  type        = map(object({
    label = string
    value = string
  }))
  default     = null 
}
