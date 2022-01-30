data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

module "eks" {
  source = "./eks"
  name   = var.cluster_name

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  kubernetes_version = var.kubernetes_version

  enable_irsa = var.enable_irsa

  eks_min_capacity     = var.eks_min_capacity
  eks_max_capacity     = var.eks_max_capacity
  eks_desired_capacity = var.eks_desired_capacity
  eks_instance_type    = var.eks_instance_type

  map_users = var.map_users
  map_roles = var.map_roles
}
