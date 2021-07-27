package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformAwsEKS(t *testing.T) {
	t.Parallel()

	private_subnets := []string{"subnet-05d6411aa893da0f5", "subnet-08f37f5a0bf4494e7", "subnet-0c4aff30b966be038"}

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "../.", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name":                 "labs-eks-test-deployment",
			"kubernetes_version":   "1.19",
			"vpc_id":               "vpc-012c1acb51eb87c20", // Pre-provisioned test VPC, specifically for EKS tests.
			"private_subnets":      private_subnets,
			"eks_min_capacity":     3,
			"eks_max_capacity":     3,
			"eks_desired_capacity": 3,
			"eks_instance_type":    "m5.medium",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
