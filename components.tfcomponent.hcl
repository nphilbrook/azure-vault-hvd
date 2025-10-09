component "prereqs" {
  for_each = var.locations

  source = "./prereqs"

  inputs = {
    default_tags        = var.default_tags
    cert_email          = var.cert_email
    zone_name           = var.environment_info[each.key].zone
    resource_group_name = var.environment_info[each.key].resource_group_name

    az_subscription_id = var.az_subscription_id
    az_tenant_id       = var.az_tenant_id
    az_client_id       = var.az_client_id
    az_client_secret   = var.az_client_secret
  }

  providers = {
    azurerm = provider.azurerm.this
    # aws     = provider.aws.this
    acme  = provider.acme.this
    local = provider.local.this
    tls   = provider.tls.this
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
