output "subnets_secondary_ranges" {
  description = "The subnets_secondary_ranges output variable from the terraform-google-network module."
  value       = module.test-vpc-module.subnets_secondary_ranges
}
