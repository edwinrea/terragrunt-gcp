terraform {
  source = "../../..//modules/argocd/"
}

include {
  path = find_in_parent_folders()
}

dependency "gke" {
  config_path = "../gke"
}

inputs = {
  gke_auth_host          = dependency.gke.outputs.host
  gke_auth_cluster_ca_certificate          = dependency.gke.outputs.cluster_ca_certificate
  gke_auth_token          = dependency.gke.outputs.token
}