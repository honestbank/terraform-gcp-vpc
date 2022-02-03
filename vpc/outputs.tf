output "network_name" {
  description = "The name of the VPC."
  value       = google_compute_network.vpc.name
}

output "primary_subnet_name" {
  description = "The primary subnets of the VPC."
  value       = google_compute_subnetwork.primary_subnet.name
}

output "primary_subnet_ip_cidr_range" {
  description = "The CIDR of the primary subnet."
  value       = google_compute_subnetwork.primary_subnet.ip_cidr_range
}

output "pods_subnet_name" {
  description = "The name of the secondary IP range built for Pods."
  value       = google_compute_subnetwork.primary_subnet.secondary_ip_range[0].range_name
}

output "pods_subnet_cidr" {
  description = "The CIDR of the Pods subnet."
  value       = google_compute_subnetwork.primary_subnet.secondary_ip_range[0].ip_cidr_range
}

output "services_subnet_name" {
  description = "The name of the secondary IP range built for Services."
  value       = google_compute_subnetwork.primary_subnet.secondary_ip_range[1].range_name
}

output "services_subnet_cidr" {
  description = "The CIDR of the Services subnet."
  value       = google_compute_subnetwork.primary_subnet.secondary_ip_range[1].ip_cidr_range
}
