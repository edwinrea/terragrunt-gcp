module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  version = "~> 2.0.0"
  network_name = local.net_name
  subnets      = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = var.subnet_primary_ip_range
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    "${local.subnet_name}" = [
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
  name = reverse(split("/", module.gcp-network.subnets_names[0]))[0]
}

resource "google_compute_router" "main" {
  name    = var.environment
  network = module.gcp-network.network_name
}

resource "google_compute_router_nat" "main" {
  name                               = "main"
  router                             = google_compute_router.main.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
