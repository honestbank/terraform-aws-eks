output "eks-cluster-endpoint" {
  value = data.aws_eks_cluster.eks-cluster.endpoint
}
output "eks-cluster-token" {
  value     = data.aws_eks_cluster_auth.eks-cluster.token
  sensitive = true
}

output "certificate_authority_data" {
  value = data.aws_eks_cluster.eks-cluster.certificate_authority.0.data
}
