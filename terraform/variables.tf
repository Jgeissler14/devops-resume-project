# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "location" {
  type    = string
  default = "westus2"
}

resource "random_id" "cluster_name" {
  byte_length = 5
}

locals {
  cluster_name = "tf-k8s-${random_id.cluster_name.hex}"
}

variable "tenant_id" {
  description = "The Azure Tenant ID"
  default     = "c6ac7581-7e72-4591-955d-fbb8c4dc1295"
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  default     = "8356492a-5b92-4829-95f0-48abf6418162"
}