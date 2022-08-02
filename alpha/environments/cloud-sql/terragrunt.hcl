terraform {
  source = "../../..//modules/cloud-sql/"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  private_network          = dependency.vpc.outputs.network_id
}

