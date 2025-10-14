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
    # aws     = provider.aws.this
    acme   = provider.acme.this
    local  = provider.local.this
    tls    = provider.tls.this
    tfe    = provider.tfe.this
    random = provider.random.this
  }
}


# component "dns_tls" {
#   for_each = var.locations

#   source = "./dns_tls"

#   inputs = {
#     resource_group_name = component.rg[each.value].resource_group_name
#     location            = component.rg[each.value].resource_group_location
#     environment         = var.environment
#     default_tags        = var.default_tags
#     username            = var.username
#   }

#   providers = {
#     azurerm = provider.azurerm.this
#     # aws     = provider.aws.this
#     acme    = provider.acme.this
#     local   = provider.local.this
#   }
# }

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
