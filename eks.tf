data "aws_eks_cluster" "eks_cluster" {
  name = module.amazon_eks.cluster_id
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.amazon_eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster.eks_cluster.token
  load_config_file       = false
}

module "amazon_eks" {
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

  map_users = [
    { "groups" : ["system:masters"], "userarn" : "arn:aws:iam::033245014990:user/jai", "username" : "jai" },                    # jai
    { "groups" : ["system:masters"], "userarn" : "arn:aws:iam::033245014990:user/peter.griffin", "username" : "peter.griffin" } # peter.griffin
  ]

  map_roles = [
    { "groups" : ["system:masters"], "rolearn" : "arn:aws:iam::106256755710:role/OrganizationAccountAccessRole", "username" : "cross-account" } # Cross Account Role
  ]

}
