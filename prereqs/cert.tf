module "tls_certs" {
  # source = "./terraform-acme-tls-azurerm"
  source = "git::ssh://github.com/hashicorp-services/terraform-acme-tls-azurerm.git?ref=8b72f32ac1cdf6af2cdcfbf9d84dae115cfa1b0e"

  dns_zone_name                = var.zone_name
  dns_zone_resource_group_name = var.resource_group_name
  tls_cert_fqdn                = "vault.${var.zone_name}"
  tls_cert_email_address       = var.cert_email
  create_cert_files            = false
}
