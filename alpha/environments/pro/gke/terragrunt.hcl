terraform {
  source = "../../..//modules/gke/"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  subnet_ip                = dependency.vpc.outputs.subnet_ip
  subnet_primary_ip_range  = dependency.vpc.outputs.subnet_primary_ip_range
  subnet_services_ip_range = dependency.vpc.outputs.subnet_services_ip_range
  subnet_pods_ip_range     = dependency.vpc.outputs.subnet_pods_ip_range
  net_name                 = dependency.vpc.outputs.network_name
  subnet_name              = dependency.vpc.outputs.network_subnet[0]
}
