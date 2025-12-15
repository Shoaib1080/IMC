variable "name" {
  type    = string
  default = "demo"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "sql_admin_user" {
  type = string
}

variable "sql_admin_password" {
  type = string
}

variable "sql_db_name" {
  type    = string
  default = "demo_db"
}
