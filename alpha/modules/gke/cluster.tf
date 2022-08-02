data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  # version                           = "19.0.0"
  # version                           = "22.0.0"
  project_id                        = var.project_id
  region                            = var.region
  zones                             = var.zones
  name                              = "${var.project_id}-gke-cluster"
  network                           = var.net_name
  subnetwork                        = var.subnet_name
  ip_range_pods                     = "ip-range-pods-${var.env}"
  ip_range_services                 = "ip-range-services-${var.env}"
  horizontal_pod_autoscaling        = true
  network_policy                    = true
  remove_default_node_pool          = true
  enable_private_endpoint           = false
  enable_private_nodes              = true
  master_ipv4_cidr_block            = var.master_cidr
  monitoring_service                = "monitoring.googleapis.com/kubernetes"
  logging_service                   = "logging.googleapis.com/kubernetes"
  enable_vertical_pod_autoscaling   = true
  regional                          = var.regional
  cluster_resource_labels           = var.labels
  service_account                   = var.service_account

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

#Se deja en false ya que crea un node_pool que da problema
  cluster_autoscaling = {
  "enabled" = false,
  "gpu_resources" = [],
  "max_cpu_cores" = 20,
  "max_memory_gb" = 20,
  "min_cpu_cores" = 3,
  "min_memory_gb" = 3
  }

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.min_count
      max_count          = var.max_count
      disk_size_gb       = var.disk_size_gb
      disk_type          = "pd-standard"
      # image_type         = "COS"
      # image_type         = "cos_containerd"
      image_type         = var.image_type
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = var.initial_node_count
    },
  ]
 }

resource "google_compute_firewall" "kubeseal-http" {
   name    = "kubeseal-http"
   network = var.net_name
   project = var.project_id

    allow {
     protocol = "tcp"
     ports    = ["8080"]
   }

    source_ranges = ["${var.master_cidr}"]
 }

 resource "google_compute_firewall" "secret-manager-webhook" {
   name    = "secret-manager-webhook"
   network = var.net_name
   project = var.project_id

    allow {
     protocol = "tcp"
     ports    = ["9443","8443","443"]
   }

    source_ranges = ["${var.master_cidr}"]
 }

 resource "time_sleep" "wait_30_seconds" {
  depends_on = [module.gke]
  create_duration = "30s"
}

module "gke_auth" {
  depends_on           = [time_sleep.wait_30_seconds]
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id           = var.project_id
  cluster_name         = module.gke.name
  location             = module.gke.location
  use_private_endpoint = false
}

# resource "google_project_service" "project" {
#   project = var.project_id
#   service = "container.googleapis.com"

#   disable_on_destroy = true
# }
