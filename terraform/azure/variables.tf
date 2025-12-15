variable "name" {
  type    = string
  default = "demo-azure"
}

variable "resource_group_name" {
  type = string
}

variable "sql_admin_user" {
  type = string
}

variable "sql_admin_password" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}
