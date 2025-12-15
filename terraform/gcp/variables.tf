variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "name" {
  type    = string
  default = "demo-gcp"
}

variable "bucket_name" {
  type = string
}

variable "db_instance_name" {
  type = string
}

variable "db_name" {
  type    = string
  default = "demo_db"
}
