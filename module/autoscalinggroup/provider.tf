terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.40.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Specify the subscription ID here
  subscription_id = "efd38b0c-916e-4a1f-b4b1-3b8422485778"
}
