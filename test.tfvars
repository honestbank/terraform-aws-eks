name               = "labs-test-vpc-deployment"
kubernetes_version = 1.19
vpc_id             = "vpc-012c1acb51eb87c20" # Pre-existing test VPC, specifically for EKS tests. 
private_subnets    = ["subnet-05d6411aa893da0f5", "subnet-08f37f5a0bf4494e7", "subnet-0c4aff30b966be038"]

eks_min_capacity     = 3
eks_desired_capacity = 3
eks_max_capacity     = 3
eks_instance_type    = "m5.medium"
