resource "google_sql_user" "main" {
  name     = var.db_username_woodlands
  instance = var.instance_name
  password = var.db_password_woodlands
  project  = var.project_id
}

resource "google_sql_user" "staging" {
  name     = var.db_username_staging
  instance = var.instance_name
  password = var.db_password_staging
  project  = var.project_id
}

resource "google_sql_user" "demo" {
  name     = var.db_username_demo
  instance = var.instance_name
  password = var.db_password_demo
  project  = var.project_id
}
