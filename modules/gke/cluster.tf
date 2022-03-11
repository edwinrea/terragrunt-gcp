module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                           = "19.0.0"
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

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  cluster_autoscaling = {
  "enabled" = true,
  "gpu_resources" = [],
  "max_cpu_cores" = 2,
  "max_memory_gb" = 2,
  "min_cpu_cores" = 1,
  "min_memory_gb" = 1
}

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.min_count
      max_count          = var.max_count
      disk_size_gb       = var.disk_size_gb
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = var.initial_node_count
    },
  ]
 }
