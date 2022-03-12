resource "google_sql_user" "main" {
  depends_on = [
    google_sql_database_instance.master
  ]
  name     = var.db_username
  instance = google_sql_database_instance.master.name
  password = var.db_password
  project  = var.project_id
}

resource "google_sql_database" "main" {
  depends_on = [
    google_sql_user.main
  ]
  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.master.name
}