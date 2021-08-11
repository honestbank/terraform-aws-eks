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

	workingDir := test_structure.CopyTerraformFolderToTemp(t, "../.", ".")
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
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
