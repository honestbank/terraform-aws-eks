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
