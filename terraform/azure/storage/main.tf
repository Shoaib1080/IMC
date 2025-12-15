provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "sa" {
  name                     = lower(replace(var.name, "-", ""))
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.name}-sql"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sql.id
  # No sku defined for mssql database here; Add additional configuration if needed.
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "sql_fqdn" {
  value = azurerm_mssql_server.sql.fully_qualified_domain_name
}
