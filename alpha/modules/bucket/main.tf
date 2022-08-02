resource "google_storage_bucket" "auto-expire" {
  name                        = var.bucket_name
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
  versioning {
      enabled = true
  }
  force_destroy = false


  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}