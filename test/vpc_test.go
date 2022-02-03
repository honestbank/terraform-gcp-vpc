package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestVpc(t *testing.T) {
	runId := strings.ToLower(random.UniqueId())
	name := fmt.Sprintf("terratest-%s", runId)

	gcpCredentials := gcp.GetGoogleCredentialsFromEnvVar(t)
	primarySubnetName := "primary-" + runId
	podsIpRangeName := "pods-" + runId
	servicesIpRangeName := "services-" + runId
	tempTestDir := ""
	vpcModulePathKey := "vpcModulePath"

	// Files to copy into test folder
	varFile := "wrapper.auto.tfvars"
	providerFile := "providers.tf"

	t.Run(name, func(t *testing.T) {

		t.Parallel()
		workingDir := filepath.Join(".", "test-runs", name)

		test_structure.RunTestStage(t, "create_test_copy", func() {
			tempTestDir = test_structure.CopyTerraformFolderToTemp(t, "../vpc", ".")
			logger.Logf(t, "path to test folder %s\n", tempTestDir)

			test_structure.SaveString(t, workingDir, vpcModulePathKey, tempTestDir)
		})

		test_structure.RunTestStage(t, "create_terratest_options", func() {

			vpcModulePath := test_structure.LoadString(t, workingDir, vpcModulePathKey)
			//terraformVars := map[string]interface{}{
			//	"google_region":      gcpIndonesiaRegion,
			//	"google_project":     gcpProject,
			//	"google_credentials": gcpCredentials,
			//	"stage":              "test",
			//}

			vpcTerratestOptions := &terraform.Options{
				TerraformDir: vpcModulePath,
				VarFiles:     []string{varFile},
				Vars: map[string]interface{}{
					"google_credentials":                   gcpCredentials,
					"network_name":                         name,
					"vpc_primary_subnet_name":              primarySubnetName,
					"vpc_secondary_ip_range_pods_name":     podsIpRangeName,
					"vpc_secondary_ip_range_services_name": servicesIpRangeName,
				},
			}

			logger.Log(t, "Created vpcTerratestOptions: ", vpcTerratestOptions)
			test_structure.SaveTerraformOptions(t, workingDir, vpcTerratestOptions)
		})

		testFileSourceDir, getTestDirErr := os.Getwd()
		if getTestDirErr != nil {
			fmt.Println("calling t.FailNow(): could not execute os.Getwd(): ", getTestDirErr)
			t.FailNow()
		}

		fmt.Println("test working directory is: ", testFileSourceDir)

		filesToCopy := []string{varFile, providerFile}

		fmt.Println("copying files: ", filesToCopy, " to temporary test dir: ", tempTestDir)
		for _, file := range filesToCopy {
			src := testFileSourceDir + "/" + file
			dest := tempTestDir + "/" + file
			copyErr := files.CopyFile(src, dest)
			if copyErr != nil {
				fmt.Println("😩 calling t.FailNow(): failed copying from: ", src, " to: ", dest, " with error: ", copyErr)
				t.FailNow()
			} else {
				fmt.Println("✌️ Success! Copied from: ", src, " to: ", dest)
			}
		}

		defer test_structure.RunTestStage(t, "cleanup/destroy", func() {
			vpcTerratestOptions := test_structure.LoadTerraformOptions(t, workingDir)
			_, destroyErr := terraform.DestroyE(t, vpcTerratestOptions)
			assert.Nil(t, destroyErr, "terraform destroy errored: ", destroyErr)
		})

		test_structure.RunTestStage(t, "init", func() {
			vpcTerratestOptions := test_structure.LoadTerraformOptions(t, workingDir)
			_, initErr := terraform.InitE(t, vpcTerratestOptions)
			assert.Nil(t, initErr, "terraform init errored: ", initErr)
		})

		test_structure.RunTestStage(t, "plan", func() {
			vpcTerratestOptions := test_structure.LoadTerraformOptions(t, workingDir)
			_, planErr := terraform.PlanE(t, vpcTerratestOptions)
			assert.Nil(t, planErr, "terraform plan errored: ", planErr)
		})

		test_structure.RunTestStage(t, "apply", func() {
			vpcTerratestOptions := test_structure.LoadTerraformOptions(t, workingDir)
			_, applyErr := terraform.InitAndApplyE(t, vpcTerratestOptions)
			assert.Nil(t, applyErr, "terraform apply errored: ", applyErr)
		})
	})
}
