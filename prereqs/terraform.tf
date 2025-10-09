terraform {
  required_version = "~>1.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.47"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
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
  }
}