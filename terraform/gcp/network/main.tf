provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  count         = length(var.subnet_ranges)
  name          = "${var.name}-subnet-${count.index}"
  ip_cidr_range = var.subnet_ranges[count.index]
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

output "network_id" { value = google_compute_network.vpc_network.id }
output "subnet_self_links" { value = google_compute_subnetwork.private[*].self_link }
