output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "network_id" {
  value = module.vpc-module.network_id
}

output "network_subnet" {
  value = module.vpc-module.subnets_names
}

output "network_name" {
  value = module.vpc-module.network_name
}

output "subnet_ip" {
  value = var.subnet_ip
}

output "subnet_primary_ip_range" {
  value = var.subnet_primary_ip_range
}

output "subnet_services_ip_range" {
  value = var.subnet_services_ip_range
}

output "subnet_pods_ip_range" {
  value = var.subnet_pods_ip_range
}