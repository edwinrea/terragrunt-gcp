provider "google" {
#   credentials = get_env("GCP_CREDENTIAL", "")
#   credentials = GCP_CREDENTIAL
  project     = "alpha-siged-education-pro"
  region      = "us-central1"
  zone        = "us-central1-a"
}

# resource "google-compute_network" "vpc_network" {
#   name = "test_terraform_vpc"
# }


resource "google_compute_network" "vpc_network" {
  project                 = "alpha-siged-education-pro"
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}