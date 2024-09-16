package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestVpc(t *testing.T) {
	runId := strings.ToLower(random.UniqueId())
	name := fmt.Sprintf("terratest-%s", runId)

	primarySubnetName := "primary-" + runId
	podsIpRangeName := "pods-" + runId
	servicesIpRangeName := "services-" + runId

	t.Run(name, func(t *testing.T) {

		t.Parallel()
		testDirectory := test_structure.CopyTerraformFolderToTemp(t, "../modules/vpc", ".")

		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: testDirectory,
			Vars: map[string]interface{}{
				"network_name":                         name,
				"vpc_primary_subnet_name":              primarySubnetName,
				"vpc_secondary_ip_range_pods_name":     podsIpRangeName,
				"vpc_secondary_ip_range_services_name": servicesIpRangeName,
				"google_project":                       "tf-shared-vpc-host-78a3",
				"google_region":                        "asia-southeast2",
				"vpc_routing_mode":                     "REGIONAL",
				"vpc_primary_subnet_ip_range_cidr":     "10.10.0.0/16",
				"vpc_secondary_ip_range_pods_cidr":     "10.20.0.0/16",
				"vpc_secondary_ip_range_services_cidr": "10.30.0.0/16",
			},
		})

		// Destroying terraform resources with 3 retries
		defer func() {
			terraform.DestroyE(t, terraformOptions)
		}()

		// Apply the Terraform configuration
		_, err := terraform.InitAndApplyE(t, terraformOptions)
		assert.NoError(t, err, "Terraform apply failed")

		// Validate outputs
		networkName := terraform.Output(t, terraformOptions, "network_name")
		assert.Equal(t, name, networkName, "Network name mismatch")

		networkId := terraform.Output(t, terraformOptions, "network_id")
		assert.NotEmpty(t, networkId, "Network ID should not be empty")

		primarySubnetNameOutput := terraform.Output(t, terraformOptions, "primary_subnet_name")
		assert.Equal(t, primarySubnetName, primarySubnetNameOutput, "Primary Subnet name mismatch")

		primarySubnetIpCidrRange := terraform.Output(t, terraformOptions, "primary_subnet_ip_cidr_range")
		assert.Equal(t, "10.10.0.0/16", primarySubnetIpCidrRange, "Primary Subnet CIDR range mismatch")

		podsSubnetName := terraform.Output(t, terraformOptions, "pods_subnet_name")
		assert.Equal(t, podsIpRangeName, podsSubnetName, "Pods Subnet name mismatch")

		podsSubnetCidr := terraform.Output(t, terraformOptions, "pods_subnet_cidr")
		assert.Equal(t, "10.20.0.0/16", podsSubnetCidr, "Pods Subnet CIDR range mismatch")

		servicesSubnetName := terraform.Output(t, terraformOptions, "services_subnet_name")
		assert.Equal(t, servicesIpRangeName, servicesSubnetName, "Services Subnet name mismatch")

		servicesSubnetCidr := terraform.Output(t, terraformOptions, "services_subnet_cidr")
		assert.Equal(t, "10.30.0.0/16", servicesSubnetCidr, "Services Subnet CIDR range mismatch")

		primarySubnetSelfLink := terraform.Output(t, terraformOptions, "primary_subnet_self_link")
		assert.NotEmpty(t, primarySubnetSelfLink, "Primary Subnet Self Link should not be empty")

		sharedVpcId := terraform.Output(t, terraformOptions, "shared_vpc_id")
		assert.Equal(t, networkId, sharedVpcId, "Shared VPC ID mismatch")

		sharedVpcSelfLink := terraform.Output(t, terraformOptions, "shared_vpc_self_link")
		assert.NotEmpty(t, sharedVpcSelfLink, "Shared VPC Self Link should not be empty")
	})
}
