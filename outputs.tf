output "eks-cluster-endpoint" {
  description = "The URI of the cluster endpoint, used for Admin tasks, i.e Kubectl"
  value       = data.aws_eks_cluster.eks-cluster.endpoint
}
output "eks-cluster-token" {
  description = "Token to access the EKS cluster"
  value       = data.aws_eks_cluster_auth.eks-cluster.token
  sensitive   = true
}

output "certificate_authority_data" {
  description = "CA data used to connect to the cluster. Outputted to allow the Kubeneted provider to install the aws_auth config map (allow allocated users to access)"
  value       = data.aws_eks_cluster.eks-cluster.certificate_authority.0.data
}
