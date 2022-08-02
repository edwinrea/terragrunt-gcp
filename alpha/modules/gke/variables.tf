variable "org"                {}
variable "env"                {}
variable "master_cidr"        {}
variable "net_name"           {}
variable "subnet_name"        {}
variable "project_id"         {}
variable "region"             {}
variable "zones"              {
  type        = list(string)
}
variable "machine_type"       {}
variable "min_count"          {}
variable "max_count"          {}
variable "disk_size_gb"       {}
variable "initial_node_count" {}
variable "regional"        {
  type   = bool
  default = false
}
variable "labels" {
  type    = map(string)
}

variable "service_account" {}
variable "image_type" {}