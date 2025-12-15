variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "node_count" {
  type    = number
  default = 2
}
