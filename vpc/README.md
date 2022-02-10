<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.primary_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The GCP project to build the VPC in. | `any` | n/a | yes |
| <a name="input_google_region"></a> [google\_region](#input\_google\_region) | The GCP region to build the VPC in. | `any` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the VPC. | `any` | n/a | yes |
| <a name="input_vpc_primary_subnet_ip_range_cidr"></a> [vpc\_primary\_subnet\_ip\_range\_cidr](#input\_vpc\_primary\_subnet\_ip\_range\_cidr) | The primary subnet IP range in CIDR notation. | `string` | n/a | yes |
| <a name="input_vpc_primary_subnet_name"></a> [vpc\_primary\_subnet\_name](#input\_vpc\_primary\_subnet\_name) | The name of the primary subnet of the VPC. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'` | `string` | n/a | yes |
| <a name="input_vpc_routing_mode"></a> [vpc\_routing\_mode](#input\_vpc\_routing\_mode) | Routing mode of the VPC | `string` | n/a | yes |
| <a name="input_vpc_secondary_ip_range_pods_cidr"></a> [vpc\_secondary\_ip\_range\_pods\_cidr](#input\_vpc\_secondary\_ip\_range\_pods\_cidr) | First (Pods) secondary IP range in CIDR notation. | `any` | n/a | yes |
| <a name="input_vpc_secondary_ip_range_pods_name"></a> [vpc\_secondary\_ip\_range\_pods\_name](#input\_vpc\_secondary\_ip\_range\_pods\_name) | Name of first secondary IP range - to be used for Kubernetes Pods. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'` | `any` | n/a | yes |
| <a name="input_vpc_secondary_ip_range_services_cidr"></a> [vpc\_secondary\_ip\_range\_services\_cidr](#input\_vpc\_secondary\_ip\_range\_services\_cidr) | Second (Services) secondary IP range in CIDR notation. | `any` | n/a | yes |
| <a name="input_vpc_secondary_ip_range_services_name"></a> [vpc\_secondary\_ip\_range\_services\_name](#input\_vpc\_secondary\_ip\_range\_services\_name) | Name of second secondary IP range - to be used for Kubernetes Services. Validation regex: `'^(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)$'` | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The id of the VPC. |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC. |
| <a name="output_pods_subnet_cidr"></a> [pods\_subnet\_cidr](#output\_pods\_subnet\_cidr) | The CIDR of the Pods subnet. |
| <a name="output_pods_subnet_name"></a> [pods\_subnet\_name](#output\_pods\_subnet\_name) | The name of the secondary IP range built for Pods. |
| <a name="output_primary_subnet_ip_cidr_range"></a> [primary\_subnet\_ip\_cidr\_range](#output\_primary\_subnet\_ip\_cidr\_range) | The CIDR of the primary subnet. |
| <a name="output_primary_subnet_name"></a> [primary\_subnet\_name](#output\_primary\_subnet\_name) | The primary subnets of the VPC. |
| <a name="output_primary_subnet_self_link"></a> [primary\_subnet\_self\_link](#output\_primary\_subnet\_self\_link) | The subnet\_self\_links output - meant to be passed to gcp-project-factory as  an input. |
| <a name="output_services_subnet_cidr"></a> [services\_subnet\_cidr](#output\_services\_subnet\_cidr) | The CIDR of the Services subnet. |
| <a name="output_services_subnet_name"></a> [services\_subnet\_name](#output\_services\_subnet\_name) | The name of the secondary IP range built for Services. |
| <a name="output_shared_vpc_id"></a> [shared\_vpc\_id](#output\_shared\_vpc\_id) | The id output of the shared VPC resource. |
| <a name="output_shared_vpc_self_link"></a> [shared\_vpc\_self\_link](#output\_shared\_vpc\_self\_link) | The self\_link output of the shared VPC resource. |
<!-- END_TF_DOCS -->
