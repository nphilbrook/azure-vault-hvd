variable "locations" {
  type = set(string)
}

variable "removed_locations" {
  type = set(string)
}

variable "default_tags" {
  description = "A map of default tags to apply to all AWS resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "The environment to use for the build. Tagging and naming."
}

variable "source_ip_cidrs" {
  type        = list(string)
  description = "A list of IPv4 CIDRs that will allow SSH ingress to bastions and HTTPS ingress to some infra."
  default     = ["163.252.128.75/32"]
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
  ephemeral   = true
}

variable "cert_email" {
  type    = string
  default = "nick.philbrook@hashicorp.com"
}

variable "environment_info" {
  type = map(object({
    location            = string
    resource_group_name = string
    zone                = string
  }))
}
