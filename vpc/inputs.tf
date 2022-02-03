variable "google_project" {
  description = "The GCP project to build the VPC in."
}

variable "network_name" {
  description = "The name of the VPC."
}

variable "google_region" {
  description = "The GCP region to build the VPC in."
}

variable "vpc_primary_subnet_ip_range_cidr" {
  type        = string
  description = "The primary subnet IP range in CIDR notation."
}

variable "vpc_primary_subnet_name" {
  type        = string
  description = "The name of the primary subnet of the VPC. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'`"
}

variable "vpc_routing_mode" {
  type        = string
  description = "Routing mode of the VPC"
}

variable "vpc_secondary_ip_range_pods_name" {
  description = "Name of first secondary IP range - to be used for Kubernetes Pods. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'`"
}

variable "vpc_secondary_ip_range_pods_cidr" {
  description = "First (Pods) secondary IP range in CIDR notation."
}

variable "vpc_secondary_ip_range_services_name" {
  description = "Name of second secondary IP range - to be used for Kubernetes Services. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'`"
}

variable "vpc_secondary_ip_range_services_cidr" {
  description = "Second (Services) secondary IP range in CIDR notation."
}
