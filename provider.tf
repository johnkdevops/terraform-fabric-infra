terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    microsoftfabric = {
      source  = "microsoft/fabric"
      version = ">=0.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "microsoftfabric" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}