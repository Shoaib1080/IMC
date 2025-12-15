provider "google" {
  project = var.project
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.name
  location = var.region

  subnetwork = var.subnetwork

  node_config {
    machine_type = "e2-medium"
  }

  initial_node_count = var.node_count
}

output "gke_endpoint" {
  value = google_container_cluster.primary.endpoint
}
