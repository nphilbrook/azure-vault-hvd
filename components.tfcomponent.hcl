component "prereqs" {
  for_each = var.locations

  source = "./prereqs"

  inputs = {
    default_tags        = var.default_tags
    cert_email          = var.cert_email
    dns_zone_name       = var.environment_info[each.key].zone
    resource_group_name = var.environment_info[each.key].resource_group_name
    location            = each.key
    default_tags        = var.default_tags
    environment         = var.environment
    vnet_cidr           = var.vnet_cidrs[each.key]
    subnet_cidrs        = var.subnet_cidrs[each.key]
    ingress_ips         = var.ingress_ips
    kv_vault_license    = var.kv_vault_license
    ssh_public_key      = var.ssh_public_key

    az_subscription_id = var.az_subscription_id
    az_tenant_id       = var.az_tenant_id
    az_client_id       = var.az_client_id
    az_client_secret   = var.az_client_secret
  }

  providers = {
    azurerm = provider.azurerm.this
    acme    = provider.acme.this
    local   = provider.local.this
    tls     = provider.tls.this
    tfe     = provider.tfe.this
    random  = provider.random.this
  }
}


component "vault_hvd" {
  for_each = var.locations

  source  = "app.terraform.io/philbrook/vault-enterprise-hvd/azurerm"
  version = "0.1.1-philbrook"


  inputs = {
    #------------------------------------------------------------------------------
    # Common
    #------------------------------------------------------------------------------
    friendly_name_prefix  = var.environment
    location              = each.key
    create_resource_group = false
    resource_group_name   = var.environment_info[each.key].resource_group_name
    vault_fqdn            = "vault.${var.environment_info[each.key].zone}"

    #------------------------------------------------------------------------------
    # Networking
    #------------------------------------------------------------------------------
    vnet_id         = component.prereqs[each.key].vnet_id
    vault_subnet_id = component.prereqs[each.key].vault_subnet_id

    #------------------------------------------------------------------------------
    # Azure Key Vault installation secrets and unseal key
    #------------------------------------------------------------------------------
    prereqs_keyvault_rg_name               = var.environment_info[each.key].resource_group_name
    prereqs_keyvault_name                  = component.prereqs[each.key].key_vault_name
    vault_license_keyvault_secret_id       = component.prereqs[each.key].vault_license_kv_secret_id
    vault_tls_cert_keyvault_secret_id      = component.prereqs[each.key].vault_cert_kv_secret_id
    vault_tls_privkey_keyvault_secret_id   = component.prereqs[each.key].vault_privkey_kv_secret_id
    vault_tls_ca_bundle_keyvault_secret_id = component.prereqs[each.key].vault_ca_bundle_kv_secret_id

    vault_seal_azurekeyvault_vault_name      = "unseal-kv"
    vault_seal_azurekeyvault_unseal_key_name = "unseal-key"

    #------------------------------------------------------------------------------
    # Compute
    #------------------------------------------------------------------------------
    vm_ssh_public_key = var.ssh_public_key
    vmss_vm_count     = 3
    vm_sku            = "Standard_D2s_v5"
  }

  providers = {
    azurerm = provider.azurerm.this
  }
}

# removed {
#   for_each = var.removed_locations
#   source   = "./rg"
#   from     = component.rg[each.value]

#   providers = {
#     azurerm = provider.azurerm.this
#   }
# }


# removed {
#   for_each = var.removed_locations
#   source   = "./dns_tls"
#   from     = component.dns_tls[each.value]

#   providers = {
#     azurerm = provider.azurerm.this
#     aws     = provider.aws.this
#   }
# }
