package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformAwsEKS(t *testing.T) {
	t.Parallel()

	name := fmt.Sprintf("labs-eks-terratest-%s", random.UniqueId())
	private_subnets := []string{"subnet-05d6411aa893da0f5", "subnet-08f37f5a0bf4494e7", "subnet-0c4aff30b966be038"}
	map_users := []interface{}{
		map[string]interface{}{
			"groups":   []string{"system:masters"},
			"userarn":  "arn:aws:iam::033245014990:user/jai",
			"username": "jai",
		},
		map[string]interface{}{
			"groups":   []string{"system:masters"},
			"userarn":  "arn:aws:iam::033245014990:user/peter.griffin",
			"username": "peter",
		},
		map[string]interface{}{ // Account for tests to run (ie. Github Actions, only)
			"groups":   []string{"system:masters"},
			"userarn":  "arn:aws:iam::106256755710:user/test-service-account",
			"username": "test-service-account",
		},
	}

	map_roles := []interface{}{
		map[string]interface{}{
			"groups":   []string{"system:masters"},
			"rolearn":  "arn:aws:iam::106256755710:role/OrganizationAccountAccessRole",
			"username": "cross-account",
		},
	}

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "../.", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name":                 name,
			"kubernetes_version":   "1.19",
			"vpc_id":               "vpc-012c1acb51eb87c20", // Pre-provisioned test VPC, specifically for EKS tests.
			"private_subnets":      private_subnets,
			"eks_min_capacity":     3,
			"eks_max_capacity":     3,
			"eks_desired_capacity": 3,
			"eks_instance_type":    "m5.medium",
			"map_roles":            map_roles,
			"map_users":            map_users,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "ap-southeast-1",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
