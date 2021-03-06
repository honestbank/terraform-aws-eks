terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

data "aws_eks_cluster" "eks-cluster" {
  name = module.amazon_eks.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = module.amazon_eks.cluster_id
}

module "amazon_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = var.name
  cluster_version = var.kubernetes_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id
  enable_irsa     = var.enable_irsa

  node_groups = {
    first = {
      desired_capacity = var.eks_desired_capacity
      max_capacity     = var.eks_max_capacity
      min_capacity     = var.eks_min_capacity

      instance_types = [var.eks_instance_type]
    }
  }

  map_users = var.map_users
  map_roles = var.map_roles
}
