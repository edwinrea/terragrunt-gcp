provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  name          = "${var.project_id}-sql-private-ip-${random_id.db_name_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.private_network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
