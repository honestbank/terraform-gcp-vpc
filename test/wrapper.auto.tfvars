google_project = "tf-shared-vpc-host-78a3"
#network_name   = "vpc"
google_region = "asia-southeast2"

vpc_routing_mode = "REGIONAL"

vpc_primary_subnet_ip_range_cidr = "10.10.0.0/16"
#vpc_primary_subnet_name          = "honestcard-compute-primary-subnet"

vpc_secondary_ip_range_pods_cidr = "10.20.0.0/16"
#vpc_secondary_ip_range_pods_name = "honestcard-compute-pods-subnet"

vpc_secondary_ip_range_services_cidr = "10.30.0.0/16"
#vpc_secondary_ip_range_services_name = "honestcard-compute-services-subnet"
