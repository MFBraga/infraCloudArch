## PROVIDER REQUIREMENTS - AZURE
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 3.0.1"
        }   
    }

    required_version = ">= 1.1.0"
}

## PROVIDER - LOCAL NAME
provider "azurerm" {
    skip_provider_registration = true
    features {
        resource_group {
            prevent_deletion_if_contains_resources = false
        }
    }
}