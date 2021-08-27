terraform {
  backend "remote" {
    organization = "honestbank"

    workspaces {
      name = "terraform-aws-eks"
    }
  }
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.52.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host = data.aws_eks_cluster.eks.endpoint

  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}


module "eks" {
  source = "./eks"
  name   = "${var.aws_vpc_name}-eks-cluster"

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  kubernetes_version = var.kubernetes_version

  enable_irsa = var.enable_irsa

  eks_min_capacity     = var.eks_min_capacity
  eks_max_capacity     = var.eks_max_capacity
  eks_desired_capacity = var.eks_desired_capacity
  eks_instance_type    = var.eks_instance_type

  map_users = var.map_users
}
