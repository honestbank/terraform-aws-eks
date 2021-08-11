package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformAwsEKS(t *testing.T) {
	t.Parallel()

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "../.", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "ap-southeast-1",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
