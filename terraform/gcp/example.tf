provider "google" {
  project = var.project
  region  = var.region
}

module "network" {
  source  = "./network"
  project = var.project
  region  = var.region
  name    = var.name
}

module "gke" {
  source     = "./gke"
  project    = var.project
  region     = var.region
  name       = var.name
  subnetwork = module.network.subnet_self_links[0]
}

module "storage" {
  source           = "./storage"
  project          = var.project
  region           = var.region
  bucket_name      = var.bucket_name
  db_instance_name = var.db_instance_name
  db_name          = var.db_name
}
