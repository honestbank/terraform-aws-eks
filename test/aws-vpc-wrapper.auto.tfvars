# TFVars file to build a VPC in the labs AWS
# Used in conjunction with the (limited) AWS credentials in the run.sh file to spin up a test VPC cluster
#
# Name: labs-test-vpc-deployment
#
# The name could probably be better. The terraform builds an example VPC in the "lab-compute" account in the Root > tf-testing > Compute Organization Unit in AWS.
# The "labs" part is to signift which AWS account to find the VPC inside.
#
# Required Inputs:
#   * name
#   * cidr (at least a /16, for AWS to allocate to the VPC as a whole)
#   * az's (Availability Zones): Where, geographically to allocate the subnets, referenced using AWS's AZ codes
#   * public_subnets: CIDR allocations for each public subnet. We use /19 as it gives us a total of 8 portions of a /16 address. 3 for Public, 3 for Private and 2 for future expansion
#   * private_subnets: IDR allocations for each public subnet. We use /19 as it gives us a total of 8 portions of a /16 address. 3 for Public, 3 for Private and 2 for future expansion

name = "terratest-"
cidr = "10.250.0.0/16"

azs             = ["ap-southeast-3a", "ap-southeast-3b", "ap-southeast-3c"]
public_subnets  = ["10.250.0.0/19", "10.250.32.0/19", "10.250.64.0/19"]
private_subnets = ["10.250.128.0/19", "10.250.160.0/19", "10.250.192.0/19"]

enable_flow_log                                 = true
flow_log_cloudwatch_log_group_retention_in_days = 30
