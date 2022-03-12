variable "project_id"        {}
variable "db_password"       {
  sensitive   = true
}
variable "org"               {}
variable "private_network"   {}
variable "region"            {}
variable "db_username"       {
  sensitive   = true
}
variable "db_name"           {
  sensitive   = true
}
variable "zone"              {}
