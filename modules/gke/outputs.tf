output "project_id" {
  value = var.project_id
}

output "region" {
  value = module.gke.region
}

output "zones" {
  value = var.zones
}

output "cluster" {
  value = module.gke.name
}

output "kubernetes_endpoint" {
  sensitive = true
  value     = module.gke.endpoint
}

output "ca_certificate" {
  sensitive = true
  value = module.gke.ca_certificate
}