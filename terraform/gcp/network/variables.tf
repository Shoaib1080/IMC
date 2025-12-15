variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "name" {
  type    = string
  default = "demo-vpc"
}

variable "subnet_ranges" {
  type    = list(string)
  default = ["10.3.1.0/24", "10.3.2.0/24"]
}
