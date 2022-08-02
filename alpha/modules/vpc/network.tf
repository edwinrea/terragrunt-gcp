locals {
  org = "alpha"
}

module "vpc-module" {
  source       = "terraform-google-modules/network/google"  
  version      = "5.0.0"
  project_id   = var.project_id
  network_name = "${local.org}-${var.project_id}-vpc"
  subnets      = [
    {
      subnet_name   = "${local.org}-${var.project_id}-${var.region}-subnet"
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    "${local.org}-${var.project_id}-${var.region}-subnet" = [
      {
        range_name    = local.subnet_pods_ip_range_name
        ip_cidr_range = var.subnet_pods_ip_range
      },
      {
        range_name    = local.subnet_services_ip_range_name
        ip_cidr_range = var.subnet_services_ip_range
      },
    ]
  }
}

data "google_compute_subnetwork" "subnet" {
  name = reverse(split("/", module.vpc-module.subnets_names[0]))[0]
  project   = var.project_id
  region = var.region
}

resource "google_compute_router" "main" {
  name    = "${var.project_id}-router"
  network = module.vpc-module.network_name
  project   = var.project_id
  region = var.region
}

resource "google_compute_router_nat" "main" {
  name                               = "main"
  router                             = google_compute_router.main.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
  project   = var.project_id
  region = var.region
}

resource "google_project_service" "project" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"

  disable_on_destroy = true
}
