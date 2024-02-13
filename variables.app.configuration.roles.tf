# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

##########################
# Roles Configuration   ##
##########################

variable "data_reader_identities" {
  type        = list(string)
  description = "The list of identities that will be granted data reader permissions"
}

variable "data_owner_identities" {
  type        = list(string)
  description = "The list of identities that will be granted data owner permissions"
  default     = []
}