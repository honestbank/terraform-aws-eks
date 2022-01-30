package test

import (
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformAwsEKS(t *testing.T) {
	t.Parallel()

	name := fmt.Sprintf("terratest-%s", random.UniqueId())

	//       // Root folder where terraform files should be (relative to the test folder)
	//       rootFolder := ".."
	//
	//       // Relative path to terraform module being tested from the root folder
	//       terraformFolderRelativeToRoot := "examples/terraform-aws-example"
	//
	//       // Copy the terraform folder to a temp folder
	//       tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)
	//
	//       // Make sure to use the temp test folder in the terraform options
	//       terraformOptions := &terraform.Options{
	//       		TerraformDir: tempTestFolder,
	//       }

	awsRegion := "ap-southeast-1"
	vpcAzs := []string{"ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"}
	vpcPublicSubnets := []string{"10.250.0.0/19", "10.250.32.0/19", "10.250.64.0/19"}
	vpcPrivateSubnets := []string{"10.250.128.0/19", "10.250.160.0/19", "10.250.192.0/19"}

	vpcBootstrapWorkingDir := test_structure.CopyTerraformFolderToTemp(t, ".", "modules/terraform-aws-vpc/aws-vpc")
	vpcBootstrapTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: vpcBootstrapWorkingDir,
		Vars: map[string]interface{}{
			"name":            name,
			"cidr":            "10.250.0.0/16",
			"azs":             vpcAzs,
			"public_subnets":  vpcPublicSubnets,
			"private_subnets": vpcPrivateSubnets,
			"enable_flow_log": true,
			"flow_log_cloudwatch_log_group_retention_in_days": 30,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})
	println(vpcBootstrapTerraformOptions)

	defer terraform.Destroy(t, vpcBootstrapTerraformOptions)

	terraform.InitAndApply(t, vpcBootstrapTerraformOptions)

	// Start EKS test code

	eksPrivateSubnets := terraform.OutputList(t, vpcBootstrapTerraformOptions, "private_subnets")
	eksVpcId := terraform.Output(t, vpcBootstrapTerraformOptions, "vpc_id")

	eksWorkingDir := test_structure.CopyTerraformFolderToTemp(t, "..", "eks")

	testWorkingDir, getwdErr := os.Getwd()
	if getwdErr != nil {
		fmt.Println("calling t.FailNow(): could not execute os.Getwd() to copy k8s provider: ", getwdErr)
		t.FailNow()
	}

	fmt.Println("test working directory is: ", testWorkingDir)

	testK8sProviderFilename := "test-kubernetes-provider.tf"

	testK8sProviderSoucePath := testWorkingDir + "/" + testK8sProviderFilename
	fmt.Println("path to test-kubernetes-provider.tf is: ", testK8sProviderSoucePath)

	testK8sProviderDestPath := eksWorkingDir + "/" + testK8sProviderFilename

	copyErr := files.CopyFile(testK8sProviderSoucePath, testK8sProviderDestPath)
	if copyErr != nil {
		fmt.Println("😩 calling t.FailNow(): failed copying test-kubernetes-provider.tf from: ", testK8sProviderSoucePath, " to working directory: ", eksWorkingDir, " with error: ", copyErr)
		t.FailNow()
	} else {
		fmt.Println("✌️ Success! Copied from: ", testK8sProviderSoucePath, " to: ", testK8sProviderDestPath)
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: eksWorkingDir,
		Vars: map[string]interface{}{
			"name":                 name,
			"kubernetes_version":   "1.21",
			"vpc_id":               eksVpcId, // Pre-provisioned test VPC, specifically for EKS tests.
			"private_subnets":      eksPrivateSubnets,
			"eks_min_capacity":     3,
			"eks_max_capacity":     3,
			"eks_desired_capacity": 3,
			"eks_instance_type":    "m5.large",
			"enable_irsa":          true,
			"map_roles": []map[string]interface{}{
				{
					"rolearn":  "arn:aws:iam::124994850539:role/OrganizationAccountAccessRole",
					"username": "service-account",
					"groups":   []string{"system:masters"},
				},
			},
			"map_users": []map[string]interface{}{
				{
					"userarn":  "arn:aws:iam::033245014990:user/jai.govindani",
					"username": "jai.govindani",
					"groups":   []string{"system:masters"},
				},
			},
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
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

	//// TODO: Validate aws-auth ConfigMap entries
}
