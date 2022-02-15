module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 2.0.0"
  project_id               = var.project_id
  name                     = local.cluster
  regional                 = false
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  # region                   = var.region
  network                  = reverse(split("/", data.google_compute_subnetwork.subnet.network))[0]
  subnetwork               = data.google_compute_subnetwork.subnet.name
  # master_ipv4_cidr_block   = var.master_cidr
  ip_range_pods            = local.subnet_pods_ip_range_name
  ip_range_services        = local.subnet_services_ip_range_name
  # create_service_account   = false
  # service_account          = var.terraform_sa_fqdn
  # enable_private_nodes     = true
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  node_pools               = [
    {
      name            = "main"
      machine_type    = var.machine_type
      min_count       = 1
      max_count       = var.max_nodes
      disk_size_gb    = 15
      disk_type       = "pd-ssd"
      auto_upgrade    = true
      # service_account = var.terraform_sa_fqdn
      service_account    = "project-service-account@gke-demo3-edwinrea.iam.gserviceaccount.com"
    },
  ]
}