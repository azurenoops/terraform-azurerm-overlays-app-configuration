# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


##########################################
# App Configuration Key Configuration   ##
##########################################

variable "app_configuration_features" {
  description = "A map of App Configuration features"
  type = map(object({
    description = string
    name        = string
    label       = string
    enabled     = bool
  }))
  default = null
}
