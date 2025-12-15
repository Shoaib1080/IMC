provider "azurerm" {
  features = {}
}

module "vnet" {
  source              = "./vnet"
  name                = var.name
  resource_group_name = var.resource_group_name
}

module "aks" {
  source              = "./aks"
  name                = var.name
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids[0]
}

module "storage" {
  source              = "./storage"
  name                = var.name
  resource_group_name = var.resource_group_name
  sql_admin_user      = var.sql_admin_user
  sql_admin_password  = var.sql_admin_password
  sql_db_name         = "${var.name}_db"
}
