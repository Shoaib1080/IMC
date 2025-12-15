provider "azurerm" {
  features {}
}

variable "name" {
  type    = string
  default = "demo-aks"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "subnet_id" {
  type = string
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
