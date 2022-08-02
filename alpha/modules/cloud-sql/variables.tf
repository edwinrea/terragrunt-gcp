variable "project_id"        {}
variable "db_password_woodlands"       {
  sensitive   = true
}
variable "env"               {}
variable "org"               {}
variable "disk_size"         {}
variable "private_network"   {}
variable "region"            {}
variable "db_username_woodlands"       {
  sensitive   = true
}
# variable "db_name"           {
#   sensitive   = true
# }
variable "zone"              {}
variable "labels" {
  type    = map(string)
}
