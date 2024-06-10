variable "google_project" {
  type        = string
  description = "The GCP project to build the VPC in."
}

variable "google_region" {
  type        = string
  description = "The GCP region to build the VPC in."
}

variable "network_name" {
  type        = string
  description = "The name of the VPC."
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
  type        = string
  description = "Name of first secondary IP range - to be used for Kubernetes Pods. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'`"
}

variable "vpc_secondary_ip_range_pods_cidr" {
  type        = string
  description = "First (Pods) secondary IP range in CIDR notation."
}

variable "vpc_secondary_ip_range_services_name" {
  type        = string
  description = "Name of second secondary IP range - to be used for Kubernetes Services. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'`"
}

variable "vpc_secondary_ip_range_services_cidr" {
  type        = string
  description = "Second (Services) secondary IP range in CIDR notation."
}

variable "enable_flow_logs" {
  type        = bool
  description = "Whether or not to enable VPC Flow logs."
  default     = false
}

variable "vpc_flow_logs_sampling" {
  type        = number
  description = "The sampling rate for VPC Flow logs."
  default     = 1

  validation {
    condition     = var.vpc_flow_logs_sampling >= 0 && var.vpc_flow_logs_sampling <= 1
    error_message = "Invalid sampling rate. Must be between 0 and 1."
  }
}

variable "vpc_flow_logs_aggregation_interval" {
  type        = string
  description = "The aggregation interval for VPC Flow logs."
  default     = "INTERVAL_5_SEC"

  validation {
    condition     = can(regex("INTERVAL_(5|30)_SEC|INTERVAL_(1|5|10|15)_MIN", var.vpc_flow_logs_aggregation_interval))
    error_message = "Invalid aggregation interval. Must be one of: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN"
  }
}

variable "vpc_flow_logs_metadata" {
  type        = string
  description = "The metadata to include in VPC Flow logs."
  default     = "INCLUDE_ALL_METADATA"

  validation {
    condition     = can(regex("INCLUDE_ALL_METADATA|EXCLUDE_ALL_METADATA|CUSTOM_METADATA", var.vpc_flow_logs_metadata))
    error_message = "Invalid metadata. Must be one of: INCLUDE_ALL_METADATA, EXCLUDE_ALL_METADATA or CUSTOM_METADATA"
  }
}

variable "vpc_flow_logs_metadata_fileds" {
  type        = list(string)
  description = "The metadata fields to include in VPC Flow logs."
  default     = []
}

variable "vpc_flow_logs_filter_expression" {
  type        = string
  description = "The filter expression for VPC Flow logs. See https://cloud.google.com/vpc/docs/flow-logs#filtering for more reference."
  default     = "true"
}
