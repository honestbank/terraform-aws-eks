data "aws_eks_cluster" "eks-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = var.name
  cluster_version = var.kubernetes_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id

  node_groups = {
    first = {
      desired_capacity = var.eks_desired_capacity
      max_capacity     = var.eks_max_capacity
      min_capacity     = var.eks_min_capacity

      instance_type = var.eks_instance_type
    }
  }


  map_users        = var.map_users
  map_roles        = var.map_roles
  write_kubeconfig = false # No point writing it in the cloud, lets get it from AWS directly afterwards
  # kubeconfig_output_path = "./"
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}
