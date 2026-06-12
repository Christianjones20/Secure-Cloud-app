terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "e94d7c3d-8fd9-446f-a175-3fecc9286401"

  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "aks" {
  name     = "rg-aks-lab"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "secure-cloud-aks"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix = "secure-clo-rg-aks-lab-e94d7c"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D4ds_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  azure_policy_enabled = true

  cost_analysis_enabled = false

  tags = {
    Environment = "Lab"
    Purpose     = "CloudSecurity"
  }
  lifecycle {
    ignore_changes = [
      default_node_pool,
      linux_profile,
      network_profile,
      oms_agent,
      tags
    ]
  }    
}
