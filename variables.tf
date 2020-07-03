variable "project_id" {
  default = "test-terraform-project-01"
}

variable "region" {
  default = "asia-southeast2"
}

variable "cluster_name_prefix" {
  default = "test-gcp-jkt-cluster"
}

variable "cluster_number" {
  # Increment this on each trial run to ensure no collisions
  default = 6
}

variable "ip_range_pods_suffix" {
  default = "pods-ip-range"
}

variable "ip_range_services_suffix" {
  default = "services-ip-range"
}

variable "network_name_suffix" {
  default = "network"
}

variable "node_pool_name_suffix" {
  default = "node-pool"
}

locals {
  cluster_name           = "${var.cluster_name_prefix}-${var.cluster_number}"
  network_name           = "${local.cluster_name}-${var.network_name_suffix}"
  subnet_name            = "${local.network_name}-subnet-01"
  ip_range_pods_name     = "${local.cluster_name}-${var.ip_range_pods_suffix}"
  ip_range_services_name = "${local.cluster_name}-${var.ip_range_services_suffix}"
  node_pool_name         = "${local.cluster_name}-${var.node_pool_name_suffix}-01"
}

variable "zones" {
  default = ["asia-southeast2-a", "asia-southeast2-b", "asia-southeast2-c"]
}

variable "release_channel" {
  type        = string
  description = "(Beta) The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  default     = "RAPID"
}
