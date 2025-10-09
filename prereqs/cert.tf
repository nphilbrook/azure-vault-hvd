module "tls_certs" {
  source = "app.terraform.io/philbrook/tls-azurerm/acme"
  version = "0.0.2"

  dns_zone_name                = var.zone_name
  dns_zone_resource_group_name = var.resource_group_name
  tls_cert_fqdn                = "vault.${var.zone_name}"
  tls_cert_email_address       = var.cert_email
  create_cert_files            = false

  az_subscription_id = var.az_subscription_id
  az_tenant_id       = var.az_tenant_id
  az_client_id       = var.az_client_id
  az_client_secret   = var.az_client_secret
}
