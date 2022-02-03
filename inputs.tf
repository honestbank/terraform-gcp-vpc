variable "google_credentials" {
  description = "GCP Service Account JSON keyfile contents."
}

variable "google_project" {
}

variable "network_name" {
}

variable "google_region" {
}

variable "vpc_primary_subnet_ip_range_cidr" {
  type        = string
  description = "The primary subnet IP range in CIDR notation."
}

variable "vpc_primary_subnet_name" {
  type        = string
  description = "The name of the primary subnet of the VPC."
}

variable "vpc_routing_mode" {
  type        = string
  description = "Routing mode of the VPC"
}

variable "vpc_secondary_ip_range_pods_cidr" {
  description = "First (Pods) secondary IP range in CIDR notation."
}

variable "vpc_secondary_ip_range_pods_name" {
  description = "Name of first secondary IP range - to be used for Kumbernetes Pods."
}

variable "vpc_secondary_ip_range_services_cidr" {
  description = "Second (Services) secondary IP range in CIDR notation."
}

variable "vpc_secondary_ip_range_services_name" {
  description = "Name of second secondary IP range - to be used for Kubernetes Services."
}
