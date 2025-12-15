variable "cluster_name" {
  type    = string
  default = "demo-eks"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_group_count" {
  type    = number
  default = 2
}
