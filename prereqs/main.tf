module "vault_prereqs" {
  source  = "app.terraform.io/philbrook/prereqs/azurerm"
  version = "0.0.2"

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
  create_vnet                    = true
  create_nat_gateway             = true
  create_nsg_nat_rule            = true
  create_bastion                 = true
  vnet_cidr                      = [var.vnet_cidr]
  bastion_subnet_cidr            = var.subnet_cidrs["bastion"]
  lb_subnet_cidr                 = var.subnet_cidrs["lb"]
  vault_subnet_cidr              = var.subnet_cidrs["vault"]
  cidr_allow_ingress_bastion_ssh = var.ingress_ips
  cidr_allow_ingress_lb_443      = data.tfe_outputs.azure_hcp_control_outputs.nonsensitive_values.ingress_ips
  cidr_ingress_lb_allow_8200     = var.ingress_ips
  cidr_ingress_vault_allow_8200  = data.tfe_outputs.azure_hcp_control_outputs.nonsensitive_values.ingress_ips
  key_vault_cidr_allow_ingress   = [] # do I need this?
  # TODO plumb this through like the ingress IPs
  bastion_ssh_public_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC48Ys2HvlHglzLbwdfxt9iK2LATImoH8VG9vWzvuiRIsa8UQxbLbk6Gutx3MpB2FZywB3ZrZfw5MqivAtJXE2Os/QmgAZQxRpV15BTzrgvbqTKyibKnmRsCG59O8icftREKY6q/gvzr67QcMhMEZLDExS8c+zycQT1xCVg1ip5PwPAwMQRxtqLvV/5B85IsJuMZi3YymYaVSJgayYBA2eM/M8YInlIDKNqekHL/cUZFG2TP98NOODsY4kRyos4c8+jkULLCOGu0rLhA7rP3NsvEbcpCOI2lS5XgxnOHIpZ42V2xGId8IRDtK4wEGAHEWmOKdOsL4Qe5AwglHMmdkZU2HKdThOb5+8pf5BDe/I9aLB3k7vW5jcOm1dyHZ0pg/Tg9hJdFCCSBm0E4EJDRzI223chgwjf+XrMDB7DHTa29KU63rDeQme89y57HkgxXCIq4EVUKRaJS1PIUI7uJKMDryd2Au/W9z4nAbindFIxHMg/eC1aW0k90ri8FebvkX0=
EOF

  # --- Key Vault "Bootstrap" Secrets --- #
  create_key_vault          = true
  kv_vault_license          = var.kv_vault_license
  kv_vault_cert_base64      = module.tls_certs.tls_cert_base64
  kv_vault_privkey_base64   = module.tls_certs.tls_privkey_base64
  kv_vault_ca_bundle_base64 = module.tls_certs.tls_ca_bundle_base64
}
