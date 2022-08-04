locals {
  env              = "prod"
  region           = "us-east4"
  org              = "alpha"
}

remote_state {
  backend = "gcs"
  config  = {
    location = "US"
    project = "${get_env("TF_VAR_project_id", "")}"
    bucket = "${get_env("TF_VAR_project_id", "")}_terraform-state"
    prefix = "${path_relative_to_include()}/terraform.tfstate"
    credentials = "${get_env("GCP_CREDENTIAL", "")}"
  }
}

inputs = {
  #Common
  credentials              = "${get_env("GCP_CREDENTIAL", "")}"
  env                      = local.env
  org                      = local.org
  region                   = local.region
  zone                     = "${local.region}-a"
  zones                    = ["${local.region}-a"]
  labels                   = {env = "prod"}
  service_account          = "${get_env("GCP_SA", "")}"
  
  
  #SQL
  disk_size                = 10
  
  #WOODLANDS
  db_username_woodlands              = "${get_env("TF_VAR_db_username_woodlands", "")}"
  db_password_woodlands              = "${get_env("TF_VAR_db_password_woodlands", "")}"

  #STAGING
  db_username_staging              = "${get_env("TF_VAR_db_username_staging", "")}"
  db_password_staging              = "${get_env("TF_VAR_db_password_staging", "")}"

  #DEMO
  db_username_demo              = "${get_env("TF_VAR_db_username_demo", "")}"
  db_password_demo              = "${get_env("TF_VAR_db_password_demo", "")}"


  #Module VPC
  subnet_ip                = "10.128.10.0/24"
  subnet_primary_ip_range  = "172.20.0.0/20"
  subnet_services_ip_range = "10.62.0.0/22"
  subnet_pods_ip_range     = "10.61.128.0/17"
  
  #Module GKE
  regional                 = false
  master_cidr              = "172.17.0.0/28"
  machine_type             = "e2-small"
  disk_size_gb             = 30
  min_count                = 1
  max_count                = 1
  initial_node_count       = 1
  image_type               = "COS_CONTAINERD"

  #Module DISK_NFS
  nfs_disk_size            = 10
  disk_name                = "gce-nfs-disk-stg"
}
