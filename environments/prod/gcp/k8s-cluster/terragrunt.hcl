terraform {
  source = "../../../..//modules/gcp/k8s-cluster/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment              = "prod"
  master_cidr              = "172.16.0.0/28"
  subnet_primary_ip_range  = "172.20.0.0/20"
  subnet_services_ip_range = "172.20.16.0/20"
  subnet_pods_ip_range     = "10.8.0.0/14"
  # region                   = "us-west1"
  machine_type             = "n1-standard-2"
  max_nodes                = 1
}