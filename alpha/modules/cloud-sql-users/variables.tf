#STAGING
variable "db_password_staging"       {
  sensitive   = true
}
variable "db_username_staging"       {
  sensitive   = true
}

#WOODLANDS
variable "db_password_woodlands"       {
  sensitive   = true
}
variable "db_username_woodlands"       {
  sensitive   = true
}

#DEMO
variable "db_password_demo"       {
  sensitive   = true
}
variable "db_username_demo"       {
  sensitive   = true
}

variable "instance_name" {}
variable "project_id" {}
