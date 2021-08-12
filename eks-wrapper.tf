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

  eks_min_capacity     = var.eks_min_capacity
  eks_max_capacity     = var.eks_max_capacity
  eks_desired_capacity = var.eks_desired_capacity
  eks_instance_type    = var.eks_instance_type
}
