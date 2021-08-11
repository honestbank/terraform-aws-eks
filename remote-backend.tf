terraform {
  backend "remote" {
    organization = "honestbank"

    workspaces {
      name = "terraform-aws-eks"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

module "eks" {
    source = "./eks"
    name   = "${var.aws_vpc_name}-eks-cluster"

    vpc_id          = var.vpc_id
    private_subnets = var.private_subnets

    kubernetes_version = var.kubernetes_version

    eks_min_capacity     = var.eks_min_capacity
    eks_max_capacity     = var.eks_max_capacity
    eks_desired_capacity = var.eks_desired_capacity
    eks_instance_type    = var.eks_instance_type
}
