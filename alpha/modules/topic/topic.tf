resource "google_pubsub_topic" "gcr" {
  name = "gcr"
  project = var.project_id

  labels = {
    env = "stg"
  }
}