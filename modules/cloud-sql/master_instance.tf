resource "google_sql_database_instance" "master" {
  name             = "${var.project_id}-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = "POSTGRES_13"
  project          = var.project_id
  deletion_protection = false
  

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier              = "db-g1-small"
    disk_size         = "10"
    backup_configuration {
      enabled = true
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
    }
    location_preference {
      zone = var.zone
    }
  }
}
