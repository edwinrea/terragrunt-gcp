resource "google_compute_disk" "default" {
  project = var.project_id
  name  = var.disk_name
  # type  = "pd-ssd"
  zone  = var.zone
  size  = var.nfs_disk_size
  labels = {
    env = "stg"
  }
}