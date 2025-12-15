variable "name" {
  type        = string
  description = "Name prefix for the resources"
  default     = "infra"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDRs"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones to distribute subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}
