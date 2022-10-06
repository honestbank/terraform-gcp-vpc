terraform {
  required_providers {
    google = {
      version = "~> 4.0"
    }

    google-beta = {
      version = "~> 4.0"
    }
  }
}

resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.google_project
  routing_mode            = var.vpc_routing_mode
  auto_create_subnetworks = false
}

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
      aggregation_interval = "INTERVAL_5_SEC"

      # Sampling is between 0-1, 0 = none, 1 = all, 0.5 = 50%
      flow_sampling = 1

      metadata = "INCLUDE_ALL_METADATA"
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
