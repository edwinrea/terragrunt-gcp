terraform {
  required_version = ">= 0.12"

  required_providers {
    google-beta = ">= 3.8"
  }
}

#WOODLANDS
resource "time_sleep" "wait_15_seconds_woodlands" {
  depends_on = [google_secret_manager_secret.cloud-sql-secret-woodlands]

  create_duration = "15s"
}
resource "google_secret_manager_secret" "cloud-sql-secret-woodlands" {
  provider = google-beta

  secret_id = "cloud-sql-secret-woodlands"

  project = var.project_id

  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret_version" "cloud-sql-secret-woodlands" {
  provider = google-beta

  secret      = google_secret_manager_secret.cloud-sql-secret-woodlands.id
  secret_data = var.db_password_woodlands

  depends_on = [time_sleep.wait_15_seconds_woodlands]
}

#STAGING
resource "time_sleep" "wait_15_seconds_staging" {
  depends_on = [google_secret_manager_secret.cloud-sql-secret-staging]

  create_duration = "15s"
}
resource "google_secret_manager_secret" "cloud-sql-secret-staging" {
  provider = google-beta

  secret_id = "cloud-sql-secret-staging"

  project = var.project_id

  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret_version" "cloud-sql-secret-staging" {
  provider = google-beta

  secret      = google_secret_manager_secret.cloud-sql-secret-staging.id
  secret_data = var.db_password_staging

  depends_on = [time_sleep.wait_15_seconds_staging]
}

#DEMO
resource "time_sleep" "wait_15_seconds_demo" {
  depends_on = [google_secret_manager_secret.cloud-sql-secret-demo]

  create_duration = "15s"
}
resource "google_secret_manager_secret" "cloud-sql-secret-demo" {
  provider = google-beta

  secret_id = "cloud-sql-secret-demo"

  project = var.project_id

  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret_version" "cloud-sql-secret-demo" {
  provider = google-beta

  secret      = google_secret_manager_secret.cloud-sql-secret-demo.id
  secret_data = var.db_password_demo

  depends_on = [time_sleep.wait_15_seconds_staging]
}