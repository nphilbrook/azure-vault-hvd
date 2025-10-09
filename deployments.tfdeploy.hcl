# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

upstream_input "env_info" {
  type   = "stack"
  source = "app.terraform.io/philbrook/azure/azure-core-infra"
}

locals {
  default_tags = {
    "created-by"   = "terraform"
    "source-stack" = "philbrook/azure-core-infra"
  }
}

store "varset" "azure_auth" {
  name     = "Azure Credentials"
  category = "env"
}

deployment "dev" {
  inputs = {
    locations          = ["eastus"]
    environment        = "dev"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.ARM_CLIENT_SECRET
    environment_info   = upstream_input.env_info.dev_environment_info
  }
}

deployment "prod" {
  inputs = {
    locations          = ["eastus"]
    environment        = "prod"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.ARM_CLIENT_SECRET
    environment_info   = upstream_input.env_info.prod_environment_info
  }
}
