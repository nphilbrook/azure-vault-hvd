module "vault_prereqs" {
  source  = "app.terraform.io/philbrook/prereqs/azurerm"
  version = "0.0.3"

  # --- Common --- #
  friendly_name_prefix  = var.environment
  location              = var.location
  resource_group_name   = var.resource_group_name
  create_resource_group = false
  common_tags           = var.default_tags

  # --- DNS --- #
  create_public_dns_zone  = false
  public_dns_zone_name    = var.dns_zone_name
  create_private_dns_zone = true
  # See if this works? Same name as public zone
  private_dns_zone_name = var.dns_zone_name

  # --- Networking --- #
  create_vnet         = true
  create_nat_gateway  = true
  create_nsg_nat_rule = true
  create_bastion      = true
  vnet_cidr           = [var.vnet_cidr]
  bastion_subnet_cidr = var.subnet_cidrs["bastion"]
  lb_subnet_cidr      = var.subnet_cidrs["lb"]
  vault_subnet_cidr   = var.subnet_cidrs["vault"]
  # getting these ingress IPs from 2 different places to
  # test a theory - it can be done either way, but the TFE
  # provider does need to be specifically auth'd with a token
  # (no magic token for stacks like there is for workspaces)
  cidr_allow_ingress_bastion_ssh = var.ingress_ips
  cidr_allow_ingress_lb_443      = data.tfe_outputs.azure_hcp_control_outputs.nonsensitive_values.ingress_ips
  cidr_ingress_lb_allow_8200     = var.ingress_ips
  cidr_ingress_vault_allow_8200  = data.tfe_outputs.azure_hcp_control_outputs.nonsensitive_values.ingress_ips
  key_vault_cidr_allow_ingress   = [] # do I need this?

  # Bastion
  bastion_ssh_public_key = var.ssh_public_key
  bastion_size           = "Standard_B2s"

  # --- Key Vault "Bootstrap" Secrets --- #
  create_key_vault          = true
  kv_vault_license          = var.kv_vault_license
  kv_vault_cert_base64      = module.tls_certs.tls_cert_base64
  kv_vault_privkey_base64   = module.tls_certs.tls_privkey_base64
  kv_vault_ca_bundle_base64 = module.tls_certs.tls_ca_bundle_base64
}
