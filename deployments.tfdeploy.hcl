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

store "varset" "azure_config" {
  name     = "Azure Config"
  category = "terraform"
}

deployment "dev" {
  inputs = {
    locations          = []
    removed_locations  = ["eastus"]
    environment        = "dev"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.stable.ARM_CLIENT_SECRET
    tfe_token          = store.varset.azure_auth.TFE_TOKEN
    environment_info   = upstream_input.env_info.dev_environment_info
    vnet_cidrs = {
      eastus = "10.128.0.0/22"
    }
    subnet_cidrs = {
      eastus = {
        bastion = "10.128.0.0/24"
        lb      = "10.128.1.0/24"
        vault   = "10.128.2.0/24"
        # reserved for future use :D
        # app = "10.128.3.0/24"
      }
    }
    ingress_ips      = store.varset.azure_config.stable.ingress_ips
    kv_vault_license = store.varset.azure_auth.stable.vault_license
    ssh_public_key   = store.varset.azure_config.stable.ssh_public_key
  }
}

deployment "prod" {
  inputs = {
    locations          = []
    removed_locations  = ["eastus"]
    environment        = "prod"
    default_tags       = local.default_tags
    az_tenant_id       = store.varset.azure_auth.stable.ARM_TENANT_ID
    az_subscription_id = store.varset.azure_auth.stable.ARM_SUBSCRIPTION_ID
    az_client_id       = store.varset.azure_auth.stable.ARM_CLIENT_ID
    az_client_secret   = store.varset.azure_auth.stable.ARM_CLIENT_SECRET
    tfe_token          = store.varset.azure_auth.TFE_TOKEN
    environment_info   = upstream_input.env_info.prod_environment_info
    vnet_cidrs = {
      eastus = "10.128.128.0/22"
    }
    subnet_cidrs = {
      eastus = {
        bastion = "10.128.128.0/24"
        lb      = "10.128.129.0/24"
        vault   = "10.128.130.0/24"
        # reserved for future use :D
        # app = "10.128.131.0/24"
      }
    }
    ingress_ips      = store.varset.azure_config.stable.ingress_ips
    kv_vault_license = store.varset.azure_auth.stable.vault_license
    ssh_public_key   = store.varset.azure_config.stable.ssh_public_key
    vault_vms_count  = 5
  }
}
