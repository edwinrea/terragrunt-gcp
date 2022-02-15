# module "gke" {
#   source                   = "terraform-google-modules/kubernetes-engine/google"
#   version = "~> 2.0.0"
#   project_id               = var.project_id
#   name                     = local.cluster
#   regional                 = false
#   region                     = "us-central1"
#   zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
#   # region                   = var.region
#   network                  = reverse(split("/", data.google_compute_subnetwork.subnet.network))[0]
#   subnetwork               = data.google_compute_subnetwork.subnet.name
#   # master_ipv4_cidr_block   = var.master_cidr
#   ip_range_pods            = local.subnet_pods_ip_range_name
#   ip_range_services        = local.subnet_services_ip_range_name
#   # create_service_account   = false
#   # service_account          = var.terraform_sa_fqdn
#   # enable_private_nodes     = true
#   http_load_balancing        = false
#   horizontal_pod_autoscaling = true
#   network_policy             = true
#   node_pools               = [
#     {
#       name            = "main"
#       machine_type    = var.machine_type
#       min_count       = 1
#       max_count       = var.max_nodes
#       disk_size_gb    = 15
#       disk_type       = "pd-ssd"
#       auto_upgrade    = true
#       # service_account = var.terraform_sa_fqdn
#       service_account    = "project-service-account@gke-demo3-edwinrea.iam.gserviceaccount.com"
#     },
#   ]
# }

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "gke-demo3-edwinrea"
  name                       = "gke-test-1"
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = "vpc-01"
  subnetwork                 = "us-central1-01"
  ip_range_pods              = "us-central1-01-gke-01-pods"
  ip_range_services          = "us-central1-01-gke-01-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "project-service-account@gke-demo3-edwinrea.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}