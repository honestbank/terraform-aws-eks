package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsEKS(t *testing.T) {
	t.Parallel()

	name := fmt.Sprintf("labs-eks-terratest-%s", random.UniqueId())
	private_subnets := []string{"subnet-000f3cf76c4b7782f", "subnet-077774cfd19cc9c7a", "subnet-0b5dcfd951cfaa94b"}
	// map_users := []interface{}{
	// 	map[string]interface{}{
	// 		"groups":   []string{"system:masters"},
	// 		"userarn":  "arn:aws:iam::033245014990:user/jai",
	// 		"username": "jai",
	// 	},
	// 	map[string]interface{}{
	// 		"groups":   []string{"system:masters"},
	// 		"userarn":  "arn:aws:iam::033245014990:user/peter.griffin",
	// 		"username": "peter",
	// 	},
	// 	map[string]interface{}{ // Account for tests to run (ie. Github Actions, only)
	// 		"groups":   []string{"system:masters"},
	// 		"userarn":  "arn:aws:iam::106256755710:user/test-service-account",
	// 		"username": "test-service-account",
	// 	},
	// }

	// map_roles := []interface{}{
	// 	map[string]interface{}{ // Account for users assuming the cross-account role to be able to access the cluster and EKS dashboard
	// 		"groups":   []string{"system:masters"},
	// 		"rolearn":  "arn:aws:iam::106256755710:role/OrganizationAccountAccessRole",
	// 		"username": "cross-account",
	// 	},
	// }

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "../.", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"name":                 name,
			"kubernetes_version":   "1.19",
			"vpc_id":               "vpc-0fc178a397554ab75", // Pre-provisioned test VPC, specifically for EKS tests.
			"private_subnets":      private_subnets,
			"eks_min_capacity":     3,
			"eks_max_capacity":     3,
			"eks_desired_capacity": 3,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "ap-southeast-1",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Set up AWS Session with AWS Go SDK
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("ap-southeast-1")},
	)

	if err != nil {
		fmt.Println("Error Creating AWS Session: ", err)
		os.Exit(1)
	}

	svc := eks.New(sess)

	endpoint := terraform.Output(t, terraformOptions, "eks-cluster-endpoint")

	input := &eks.DescribeClusterInput{
		Name: aws.String(name),
	}

	result, err := svc.DescribeCluster(input)

	if err != nil {
		fmt.Println("Error Describing Cluster")
		os.Exit(1)
	}

	// Validate Correct Cluster Name
	assert.Equal(t, name, *result.Cluster.Name)

	// Validate Correct Cluster Endpoint
	assert.Equal(t, endpoint, *result.Cluster.Endpoint)

}
