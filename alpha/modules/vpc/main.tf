terraform {
  backend "gcs" {
  }
}

locals {
  net_name                      = "${var.org}-${var.project_id}-vpc"
  subnet_name                   = "${var.org}-${var.project_id}-${var.region}-subnet"
  subnet_pods_ip_range_name     = "ip-range-pods-${var.env}"
  subnet_services_ip_range_name = "ip-range-services-${var.env}"
}