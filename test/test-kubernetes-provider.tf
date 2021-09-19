provider "kubernetes" {
  host = data.aws_eks_cluster.eks-cluster.endpoint

  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks-cluster.token
}
