# These variables are test values used to run this module independently for manual testing and CI runs.
# This root folder should not be included in parent modules. Root modules should source the /eks folder directly.

cluster_name         = "labs-eks-terratest-eks-cluster"
aws_vpc_name         = "labs-eks-terratest"
aws_region           = "ap-southeast-1"
vpc_id               = "vpc-0fc178a397554ab75" // Pre-provisioned test VPC, specifically for EKS tests.
private_subnets      = ["subnet-000f3cf76c4b7782f", "subnet-077774cfd19cc9c7a", "subnet-0b5dcfd951cfaa94b"]
kubernetes_version   = "1.20"
eks_min_capacity     = 1
eks_max_capacity     = 1
eks_desired_capacity = 1
eks_instance_type    = "m5.large"
enable_irsa          = true
map_users = [
  {
    userarn  = "arn:aws:iam::033245014990:user/peter.griffin"
    username = "peter.griffin"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws:iam::033245014990:user/jai.govindani"
    username = "jai"
    groups   = ["system:masters"]
  },
]

map_roles = [
  {
    rolearn  = "arn:aws:iam::124994850539:role/OrganizationAccountAccessRole"
    username = "service-account"
    groups   = ["system:masters"]
  },
]
