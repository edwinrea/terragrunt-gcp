locals {
  region = "us-east4"
  org    = "alpha"
}

# remote_state {
#   backend = "gcs"
#   config  = {
#     location = "US"
#     #TODO: Definir nomenclatura del proyecto

#     #TODO: Definir nomenclatura para el nombre del bucket
#     bucket = "${get_env("TF_VAR_project_id", "")}_terraform-state"

#     prefix = "${path_relative_to_include()}/terraform.tfstate"

#     #TODO: Definir como se setea la credencial del sa
#     credentials = "${get_env("GCP_CREDENTIAL", "")}"

#   }
# }

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
  credentials = "${get_env("GCP_CREDENTIAL", "")}"
  org         = local.org
  region      = local.region
  zone        = "${local.region}-a"
  zones       = ["${local.region}-a"]

  #Module VPC
  subnet_ip                = "10.128.10.0/24"
  subnet_primary_ip_range  = "172.20.0.0/20"
  subnet_services_ip_range = "10.62.0.0/22"
  subnet_pods_ip_range     = "10.61.128.0/17"
}
