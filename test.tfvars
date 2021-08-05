# TFVARS file to but an EKS cluster in a pre-provisoned VPC.
# (Why a preprovisioned VPC, because this submodule is only concerned about the EKS creation piece of the puzzle, 
#  and EKS requires a VPC to run/install into
#
# Name: labs-test-eks-deployment
# As with the terrafrom-aws-vpc repo, the name could probably be better. The terraform builds an example EKS cluster in the "lab-compute" account in the Root > tf-testing > Compute Organization Unit in AWS.
# The "labs" part is to signify which AWS account to find the EKS cluster inside.

# Required Inputs:
#   * Name: Name of the EKS cluster
#   * kubernetes_version: Version of Kubernetes to use in the EKS cluster. Currently 1.19 is the latest offered. 
#   * vpc_id: AWS id for the VPC to install the EKS cluster into
#   * private_subnets: The AWS id's for the subnet's used by the EKS cluster.
#   * eks_min_capacity: Minimum cluster size
#   * eks_desired_capacity: How many nodes should be running when everything is running as normal
#   * eks_max_capacity: How many nodes are allowed to run in total
#   * eks_instance_type: AWS EC2 instance type to run the nodes on. 
#
#   * map_users: A Map comprising of the AWS arn and username for individual users and the group they are to be added to. 
#
#   * map_roles: A Map comprising of the AWS arn and username for roles (service accounts or roles assumed using STS)
#     that can access the cluster. This is included so the EKS dashboard (which is accessed via STS) can be viewed in
#     the AWS console, and so we are able to edit the aws_auth config map which is "owned" by EKS, but not part of the
#     EKS config itself, as it's applied to Kubernetes directly. Without access rights, we cannot edit this file.

name               = "labs-test-vpc-deployment"
kubernetes_version = 1.19
vpc_id             = "vpc-012c1acb51eb87c20" # Pre-existing test VPC, specifically for EKS tests. 
private_subnets    = ["subnet-05d6411aa893da0f5", "subnet-08f37f5a0bf4494e7", "subnet-0c4aff30b966be038"]

eks_min_capacity     = 3
eks_desired_capacity = 3
eks_max_capacity     = 3
eks_instance_type    = "m5.medium"
