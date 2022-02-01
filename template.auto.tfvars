# These variables are test values used to run this module independently for manual testing and CI runs.
# This root folder should not be included in parent modules. Root modules should source the /eks folder directly.

cluster_name = "manual-test"
aws_vpc_name = "labs-test-vpc-deployment"
aws_region   = "ap-southeast-1"

# lab compute test vpc
#vpc_id               = "vpc-0fc178a397554ab75" // Pre-provisioned test VPC, specifically for EKS tests.
#private_subnets      = ["subnet-000f3cf76c4b7782f", "subnet-077774cfd19cc9c7a", "subnet-0b5dcfd951cfaa94b"]

# default VPC in lab-compute
vpc_id          = "vpc-71f83217" // Pre-provisioned test VPC, specifically for EKS tests.
private_subnets = ["subnet-9440efdc", "subnet-d50cb3b3", "subnet-a8eb81f1"]

# test-compute VPC
#vpc_id          = "vpc-001a8eeb991091c73" // Pre-provisioned test VPC, specifically for EKS tests.
#private_subnets = ["subnet-0e85ca5e003c8c452", "subnet-0a097737308c9080d", "subnet-00bca668fb7ab9d54"]


kubernetes_version   = "1.21"
eks_min_capacity     = 3
eks_max_capacity     = 6
eks_desired_capacity = 3
eks_instance_type    = "m5.xlarge"
enable_irsa          = true
map_users = [
  {
    userarn  = "arn:aws:iam::033245014990:user/jai.govindani"
    username = "jai.govindani"
    groups   = ["system:masters"]
  },
]

map_roles = []
