provider "google" {
  project = var.project
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = var.force_destroy
}

resource "google_sql_database_instance" "mysql" {
  name             = var.db_instance_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
    }
  }
}

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.mysql.name
}

output "bucket_name" { value = google_storage_bucket.bucket.name }
output "db_instance_endpoint" { value = google_sql_database_instance.mysql.connection_name }
