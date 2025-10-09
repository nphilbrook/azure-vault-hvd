variable "zone_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "cert_email" {
  type = string
}

variable "az_subscription_id" {
  type        = string
  description = "Azure Subscription ID where resources will be created"
}

variable "az_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "az_client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "az_client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}
