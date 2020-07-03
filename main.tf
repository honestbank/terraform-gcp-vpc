provider "google" {
  # Use 'export GCLOUD_CREDENTIALS="PATH_TO_KEYFILE_JSON"' instead of
  # committing a keyfile to versioning
  # credentials = file("PATH_TO_KEYFILE_JSON")
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  version = "~> 3.23.0"
  region  = var.region
}

# To try
# Create VPC manually in https://console.cloud.google.com/networking/networks/list?project=test-terraform-project-01&authuser=0&organizationId=189681559562
# Remove 'routing_mode' - not sure what this does
# Set subnet mode to automatic (automatic subnet creation)
# Copy GCP IP ranges?
module "test-vpc-module" {
  source       = "./modules/terraform-google-network"
  project_id   = var.project_id
  network_name = local.network_name
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = local.ip_range_pods_name
        ip_cidr_range = "10.12.0.0/16"
      },
      {
        range_name    = local.ip_range_services_name
        ip_cidr_range = "10.14.0.0/16"
      },
    ]
  }
}
