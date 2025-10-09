module "tls_certs" {
  source = "./terraform-acme-tls-azurerm"

  dns_zone_name                = var.zone_name
  dns_zone_resource_group_name = var.resource_group_name
  tls_cert_fqdn                = "vault.${var.zone_name}"
  tls_cert_email_address       = var.cert_email
  create_cert_files            = false
}
