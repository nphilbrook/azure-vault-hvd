output "vnet_name" {
  value = module.vault_prereqs.vnet_name
}

output "vnet_id" {
  value = module.vault_prereqs.vnet_id
}

output "vault_subnet_id" {
  value = module.vault_prereqs.vault_subnet_id
}

output "key_vault_name" {
  value = module.vault_prereqs.key_vault_name
}

output "vault_license_kv_secret_id" {
  value = module.vault_prereqs.vault_license_kv_secret_id
}

output "vault_cert_kv_secret_id" {
  value = module.vault_prereqs.vault_cert_kv_secret_id
}

output "vault_privkey_kv_secret_id" {
  value = module.vault_prereqs.vault_privkey_kv_secret_id
}

output "vault_ca_bundle_kv_secret_id" {
  value = module.vault_prereqs.vault_ca_bundle_kv_secret_id
}
