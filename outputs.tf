output "vpc_network_name" {
  description = "The name of the VPC."
  value       = module.vpc.network_name
}

output "vpc_network_id" {
  description = "The id of the VPC."
  value       = module.vpc.network_id
}

output "primary_subnet_name" {
  description = "The primary subnets of the VPC."
  value       = module.vpc.primary_subnet_name
}

output "primary_subnet_ip_cidr_range" {
  description = "The CIDR of the primary subnet."
  value       = module.vpc.primary_subnet_ip_cidr_range
}

output "pods_subnet_name" {
  description = "The name of the secondary IP range built for Pods."
  value       = module.vpc.pods_subnet_name
}

output "pods_subnet_cidr" {
  description = "The CIDR of the Pods subnet."
  value       = module.vpc.pods_subnet_cidr
}

output "services_subnet_name" {
  description = "The name of the secondary IP range built for Services."
  value       = module.vpc.services_subnet_name
}

output "services_subnet_cidr" {
  description = "The CIDR of the Services subnet."
  value       = module.vpc.services_subnet_cidr
}

output "primary_subnet_self_link" {
  description = "The subnet_self_links output - meant to be passed to gcp-project-factory as  an input."
  value       = module.vpc.primary_subnet_self_link
}

output "shared_vpc_id" {
  description = "The id output of the shared VPC resource."
  value       = module.vpc.shared_vpc_id
}

output "shared_vpc_self_link" {
  description = "The self_link output of the shared VPC resource."
  value       = module.vpc.shared_vpc_self_link
}
