required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~>4.47"
  }
  # aws = {
  #   source  = "hashicorp/aws"
  #   version = "~>6.0"
  # }
  acme = {
    source  = "vancluever/acme"
    version = "~>2.23"
  }
  local = {
    source  = "hashicorp/local"
    version = "~>2.5"
  }
  tls = {
    source  = "hashicorp/tls"
    version = "~>4.1"
  }
  tfe = {
    source  = "hashicorp/tfe"
    version = "~>0.70"
  }
  random = {
    source  = "hashicorp/random"
    version = "~>3.7"
  }
}

provider "azurerm" "this" {
  config {
    use_cli                         = false
    resource_provider_registrations = "none"
    resource_providers_to_register  = ["Microsoft.KeyVault"]

    tenant_id       = var.az_tenant_id
    subscription_id = var.az_subscription_id
    client_id       = var.az_client_id
    client_secret   = var.az_client_secret

    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
  }
}

provider "acme" "this" {
  config {
    server_url = "https://acme-v02.api.letsencrypt.org/directory"
  }
}

provider "local" "this" {
  config {}
}

provider "tls" "this" {
  config {}
}

provider "random" "this" {
  config {}
}

provider "tfe" "this" {
  config {
    organization = "philbrook"
    token        = var.tfe_token
  }
}
