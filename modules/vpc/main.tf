resource "google_compute_network" "vpc" {
  #checkov:skip=CKV2_GCP_18: Firewall rules are configured elsewhere.

  name                    = var.network_name
  project                 = var.google_project
  routing_mode            = var.vpc_routing_mode
  auto_create_subnetworks = false
}

#tfsec:ignore:google-compute-enable-vpc-flow-logs - False positive, we are enabling flow logs conditionally
resource "google_compute_subnetwork" "primary_subnet" {
  ip_cidr_range            = var.vpc_primary_subnet_ip_range_cidr
  name                     = var.vpc_primary_subnet_name
  network                  = google_compute_network.vpc.id
  region                   = var.google_region
  project                  = var.google_project
  private_ip_google_access = true

  stack_type = "IPV4_ONLY"

  dynamic "log_config" {
    for_each = var.enable_flow_logs ? [1] : []

    content {
      aggregation_interval = var.vpc_flow_logs_aggregation_interval
      filter_expr          = var.vpc_flow_logs_filter_expression
      flow_sampling        = var.vpc_flow_logs_sampling
      metadata             = var.vpc_flow_logs_metadata
      metadata_fields      = var.vpc_flow_logs_metadata_fileds
    }
  }

  secondary_ip_range {
    ip_cidr_range = var.vpc_secondary_ip_range_pods_cidr
    range_name    = var.vpc_secondary_ip_range_pods_name
  }
  secondary_ip_range {
    ip_cidr_range = var.vpc_secondary_ip_range_services_cidr
    range_name    = var.vpc_secondary_ip_range_services_name
  }

  depends_on = [google_compute_network.vpc]
}
